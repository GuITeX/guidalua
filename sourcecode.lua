-- a LuaTeX small library to typeset source code

local sclib = {} -- main container

-- global parameters (default values)
-- this table will be set as metatable of the data object
sclib._parameters = {
    prompt = "> ",
    run    = false,
}
sclib._parameters.__index = sclib._parameters

-- setup global parameters
function sclib:_set_parameters(opt)
    for k, v in pairs(opt) do
        if self._parameters[k] then
            self._parameters[k] = v
        end
    end
end

-- methods

-- selecting lines in the source code
function sclib._parameters:select_lines(opt)
    if type(opt) == "string" then
        self.delim_key = opt
    elseif type(opt) == "table" then
        if opt.delim_key then
            self.delim_key = opt.delim_key
        end
    end
    return self
end

function sclib._parameters:add_output(opt)
    self.run = true
    if type(opt) == "table" then
        if opt.prompt then -- local prompt parameter
            self.prompt = opt.prompt
        end
        if opt.delim_run then -- delim_run otherwise all
            self.delim_run = true
        end
    end
    return self
end

-- user's interface costructor function
function sclib._from_file(filename)
    local task = {filename = filename}
    setmetatable(task, sclib._parameters)
    return task
end

function sclib._from_lines(tcode)
    local task = {lines = tcode}
    setmetatable(task, sclib._parameters)
    return task
end

function sclib._from_string()
    local task = {lines = sclib.lines}
    sclib.lines = nil
    setmetatable(task, sclib._parameters)
    return task
end

-- aux functions
local function getkey(line)
    local rg = "^%-%-%-<<<(%s*)([%a%d_%-]+)(%s*)"
    local s1, key, s2 = string.match(line, rg)
    if key then
        local rest = line:sub(6+#s1+#key+#s2+1)
        local s3 = string.match(rest, "(%s*)$")
        return key, rest:sub(1,-#s3-1)
    end
end

local function getend(line)
    local closing = "^%-%-%->>>%s*$"
    if string.match(line, closing) then
        return true
    else
        return false
    end
end

--
local function filter_lines(tlines, delim_key)
    local i, j
    if type(delim_key) ~= "string" or delim_key == "" then
        return i, j
    end

    local is_open = false
    for c, line in ipairs(tlines) do
        if is_open then
            if getend(line) then
                return i, c + 1
            end
        else -- lines before
            local key, rest = getkey(line)
            if key and key == delim_key then
                -- delim open code line
                is_open = true
                i = c + 1
            end
        end
    end
    if is_open then
        error("Not close delimiter in the source lines")
    else
        error("Delimiter not found in the source lines")
    end
end

local function get_lines(filename, delim_key)
    local l = {}
    if type(delim_key) ~= "string" or delim_key == "" then
        for line in io.lines(filename) do
            l[#l+1] = line
        end
        return l
    end

    local is_open = false
    for line in io.lines(filename) do
        if is_open then
            if getend(line) then
                return l
            else
                l[#l+1] = line
            end
        else -- lines before
            local key, rest = getkey(line)
            if key and key == delim_key then
                -- delim open code line
                is_open = true
            end
        end
    end
    if is_open then
        error("Not close delimiter in the source file")
    else
        error("Delimiter not found in the source file")
    end
end


local function run(code, i, j)
    local filename
    if type(code) == "table" then -- limited run
        filename = "tmp.lua"
        local flua = io.open(filename, "w")
        flua:write(table.concat(code, "\n", i, j))
        flua:close()
    elseif type(code) == "string" and code ~="" then
        filename = code
    end
    local f = io.popen("luatex --luaonly "..filename)
    local l = {}
    for line in f:lines() do
        l[#l+1] = line
    end
    return l
end

function sclib._parameters:_typeset()
    local tkprint = sclib.tkprint
    local codelines, source -- line to typeset and line to execute
    local i, j -- limit index
    if self.filename then
        codelines = get_lines(self.filename, self.delim_key)
        if self.delim_run then
            source = codelines
        else
            source = self.filename
        end
    elseif self.lines then
        codelines = self.lines
        i, j = filter_lines(self.lines, self.delim_key)
        source = self.lines
    end
    if #codelines > 0 then
        tkprint([=[\begin{lstlisting}[style=lua]]=])
        for idx, l in ipairs(codelines) do
            if i and (idx >= i and idx <= j) then
                tkprint(l)
            else
                tkprint(l)
            end
        end
        tkprint([=[\end{lstlisting}]=])
        if self.run then
            local tout = run(source, i, j)
            tkprint([=[\vspace*{-1.5ex}\begin{lstlisting}[style=out]]=])
            for _, l in ipairs(tout) do
                tkprint(self.prompt.. l)
            end
            tkprint([=[\end{lstlisting}]=])
        end
    end
end

return sclib

