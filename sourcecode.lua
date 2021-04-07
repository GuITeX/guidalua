-- a LuaTeX small library to typeset source code along with its console output

-- aux functions

local function sendlua_to_latexenv(buf, start, stop, prt)
    assert(stop >= start)
    prt([=[\begin{lstlisting}[style=lua]]=])
    for l = start, stop do
        prt(buf[l])
    end
    prt([[\end{lstlisting}]])
end

local function sendterminal_to_latexenv(buf, prompt, prt)
    assert(#buf > 0)
    prt([=[\vspace*{-1.5ex}\begin{lstlisting}[style=out,numbers=none]]=])
    for _, l in ipairs(buf) do
        prt(prompt .. l)
    end
    prt([[\end{lstlisting}]])
end

local function run_buffer(buf, last)
    local filename = "tmp.lua"
    local flua = io.open(filename, "w")
    flua:write(table.concat(buf, "\n", 1, last))
    flua:close()
    local f = io.popen("texlua "..filename)
    local l = {}
    for line in f:lines() do
        l[#l+1] = line
    end
    return l
end

local function run_file(filename)
    local f = assert(io.popen("texlua "..filename))
    local l = {}
    for line in f:lines() do
        l[#l+1] = line
    end
    return l
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


local sourcecode = {
    prompt = "> ",
    _buffer = {},
    _counter = 0,
    _opt_key = {
        file   = "_file",
        run    = "_run",
        select = "_sel",
    }
}

-- luatex callback function 'process_input_buffer'
function sourcecode.process_input_buffer(line)
    if line:match [[\end{lines}]] then
        return line
    else
        if not (line == '' and sourcecode._counter == 0) then
            sourcecode._counter = sourcecode._counter + 1
            local buf = sourcecode._buffer
            buf[sourcecode._counter] = line
	    end
        return ''
    end
end

function sourcecode.process_input_buffer_star(line)
    if line:match [[\end{linesrun}]] then
        return line
    else
        if not (line == '' and sourcecode._counter == 0) then
            sourcecode._counter = sourcecode._counter + 1
            local buf = sourcecode._buffer
            buf[sourcecode._counter] = line
	    end
        return ''
    end
end

-- methods

function sourcecode:reset()
    self._counter = 0
    self._file = nil
    self._run = nil
    self._sel = nil
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

-- file
-- select
-- run
-- lines of code comes from a source file
-- lines of code comes from the luatex callback
function sourcecode:typeset()
    local buffer = self._buffer
    local counter = self._counter
    assert(counter > 0, "Empty buffer. Maybe you forget to run load_file()")
    local prt = self._tkprint
    sendlua_to_latexenv(buffer, 1, counter, prt)
    if self._run then
        local filename = self._file
        if filename and (not self._sel) then
            local term_output = run_file(filename)
            sendterminal_to_latexenv(term_output, self.prompt, prt)
        else
            local term_output = run_buffer(buffer, counter)
            sendterminal_to_latexenv(term_output, self.prompt, prt)
        end
    end
    self:reset()
end

return sourcecode
