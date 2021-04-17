-- a LuaTeX small library to typeset source code along with its console output

-- aux functions

local function sendindex_file(path, prt)
    local fmt = [=[\index{file!%s@\filestyle{%s}|textsc}]=]
    prt(fmt:format(path, path))
end

local function sendcode_to_latexenv(buf, stop, style, tcb, prt)
    assert(stop > 0)
    local tcb_s
    if tcb then
        tcb_s = ",numbers=none,xleftmargin=0pt,aboveskip=0pt,belowskip=0pt"
    else
        tcb_s = ""
    end
    local begin = string.format([=[\begin{lstlisting}[style=%s%s]]=], style, tcb_s)
    prt(begin)
    prt(table.concat(buf, string.char(13), 1, stop))
    prt([[\end{lstlisting}]])
end

local function sendterminal_to_latexenv(term_buf, prt)
    if not term_buf then return end
    prt([=[\vspace*{-1.5ex}\begin{lstlisting}[style=sourcecodeterm,numbers=none]]=])
    prt(table.concat(term_buf))
    prt([[\end{lstlisting}]])
end

local function run_file(filename, prompt)
    local f = assert(io.popen("texlua "..filename))
    local l = {}
    local i = 0
    for line in f:lines() do
        i = i + 1
        l[#l+1] = prompt
        l[#l+1] = line
        l[#l+1] = string.char(13)
    end
    if i > 0 then
        return l
    end
end

local function run_buffer(buf, last, prompt)
    local filename = "tmp.lua"
    local flua = io.open(filename, "w")
    flua:write(table.concat(buf, "\n", 1, last))
    flua:close()
    return run_file(filename, prompt)
end

local function getkey(line)
    local rg = "^%-%-%-<<<%s*([%a%d_%-]+)%s*"
    local key = string.match(line, rg)
    return key
end

local function getend(line)
    local closing = "^%-%-%->>>%s*$"
    if string.match(line, closing) then
        return true
    end
end

local function get_lines(buf, filename, delim_key)
    local l = 0
    if delim_key then
        assert(type(delim_key) == "string")
        local is_open = false
        for line in io.lines(filename) do
            if is_open then
                if not getend(line) then
                    l = l + 1
                    buf[l] = line
                else
                    return l
                end
            else -- lines before the delimiter signal
                local key = getkey(line)
                if key and key == delim_key then
                    -- block opened
                    is_open = true
                end
            end
        end
        if is_open then
            error("Unclosed delimiter in the source file")
        else
            error("Delimiter not found in the source file")
        end
    else
        for line in io.lines(filename) do
            l = l + 1
            buf[l] = line
        end
        return l
    end
end

local function extract_ext(path)
    local e = path:match "%.(%a+)$"
    return e:lower()
end

-- library table
local sourcecode = {
    prompt = "> ",
    _buffer = {},
    _counter = 0,
    _opt_key = {
        file      = "_file",
        run       = "_run",
        select    = "_sel",
        tex       = "_tex",
        lua       = "_lua",
        tcolorbox = "_tcb",
        indexfile = "_indexfile",
    },
    _ext_style = {
        tex = "sourcecodelatex",
        lua = "sourcecodelua",
    },
}

-- luatex callback function 'process_input_buffer'
function sourcecode.process_input_buffer(line)
    if line:match [[\end{lines}]] then
        return line
    else
        if sourcecode._counter == 0 then
            -- attribute processing (partial impl of ECMA-335)
            local attr = line:match "%s*#%[%s*(.-)%s*%]"
            if attr then
                local _rk, lv = attr:match "(%S+)%s*=%s*(%S+)"
                if _rk then
                    attr = _rk
                end
                local field = sourcecode._opt_key[attr]
                if field then
                    assert(
                        not sourcecode[field],
                        "Duplicate attribute entry '"..attr.."'"
                    )
                    sourcecode[field] = lv and lv or true
                else
                    error("Attribute '"..attr.."' not found")
                end
                return ""
            end
            -- initial blank lines
            if line == "" then
                return ""
            end
            sourcecode._counter = 1
            sourcecode._buffer[1] = line
            return ""
        end
        -- common line  of code
        sourcecode._counter = sourcecode._counter + 1
        sourcecode._buffer[sourcecode._counter] = line
        return ""
    end
end

-- methods

function sourcecode:reset()
    self._counter = 0
    self._file = nil
    self._run = nil
    self._sel = nil
    self._tex = nil
    self._lua = nil
    self._tcb = nil
    self._indexfile = nil
    return self
end

function sourcecode:option(opt)
    assert(type(opt) == "table")
    for k, val in pairs(opt) do
        local inner_k = self._opt_key[k]
        if not inner_k then
            error("Option key '"..k.."' not found")
        end
        self[inner_k] = val
    end
    return self
end

function sourcecode:index_file()
    local file = self._file
    if file then
        self._indexfile = file
    end
    return self
end

function sourcecode:trim_tail()
    local buf = self._buffer
    local counter = self._counter
    if counter > 0 then
        while buf[counter] == '' do
            counter = counter - 1
        end
    end
    self._counter = counter
    return self
end

function sourcecode:load_file()
    local filename = self._file
    assert(type(filename) == "string", "Do you remember to run option()?")
    local buf = self._buffer
    local kselect = self._sel
    local counter = get_lines(buf, filename, kselect)
    assert(counter > 0)
    self._counter = counter
    return self
end

-- lines of code comes from a source file
-- lines of code comes from the luatex callback
-- option:
-- file        = "_file",
-- run         = "_run",
-- select      = "_sel",
-- tex         = "_tex",
-- lua         = "_lua",
-- tcolorbox = "_tcb",
-- indexfile = "_indexfile",
function sourcecode:typeset()
    local buffer = self._buffer
    local counter = self._counter
    assert(counter > 0, "Empty buffer. Maybe you forget to run load_file()")
    local prt = self._tkprint
    local filename = self._file
    -- code style
    local ext
    local lua, tex = self._lua, self._tex
    if filename then
        assert( (not lua) and (not tex) )
        ext = extract_ext(filename)
        if ext == "sty" then ext = "tex" end
    else
        if lua then
            assert(not tex)
            ext = "lua"
        elseif tex then
            assert(not lua)
            ext = "tex"
        else
            ext = "lua"
        end
    end
    local code_style = assert(self._ext_style[ext])
    -- we are inside a tcolorbox?
    local tcb = self._tcb
    local path = self._indexfile
    if path then
        sendindex_file(path, prt)
    end
    sendcode_to_latexenv(buffer, counter, code_style, tcb, prt)
    if self._run then
        local term_output
        if filename and (not self._sel) then
            term_output = run_file(filename, self.prompt)
        else
            term_output = run_buffer(buffer, counter, self.prompt)
        end
        sendterminal_to_latexenv(term_output, prt)
    end
    self:reset()
end

return sourcecode
