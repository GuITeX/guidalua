-- filename: app-reg/lib-logger.lua

local register = {
    _iArchive = {},
    _logList = {},
}

local mt_reg = {
    __to_string = function (reg)
        local t = {}
        local fmt = "[%03d] '%s'%s"
        local fmt_s = " with format function '%s'"
        for pos, info in ipairs(self._logList) do
            local fmt_id = info[2]
            local s = fmt_id and fmt_s:format(fmt_id) or ""
            t[#t + 1] = fmt:format(pos, info[1], s)
        end
        return table.concat(t, "\n")
    end
}
setmetatable(register, mt_reg)

local loglib = {
    filename = "history.log",
    sep = ", ",
    _optkey = {
        filename = true,
        sep = true,
    }
}

function loglib:setup(key, val) --> ok, err
    if not val then
        assert(type(key) == "table")
        for k, v in pairs(key) do
            local ok, err = self:setup(k, v)
            if err then return ok, err end
        end
    else
        if not self._optkey[key] then return false, "key not found" end
        self[key] = val
    end
    return true, nil
end

function loglib:append(tline)
    local t = {}
    for _, info in ipairs(tline) do
        t[#t + 1] = info[2]
    end
    local f = io.open(self.filename, "a+")
    local sep = self.sep
    f:write(table.concat(t, sep))
    f:write(string.char(10))
    f:close()
end

local mt = {
    __call = function (_, ilist)
        return loglib, register:_define_or_default(ilist)
    end
}

local lib = {}
setmetatable(lib, mt)

-- public methods

-- check and install a new `Info` object
function register:install(itab)
    local id = assert(itab.id) -- mandatory string field `id`
    assert(type(id) == "string")
    -- have we an `id` already saved?
    local arch = self._iArchive
    assert(not arch[id], "id '"..id.."' is not new")
    -- check `info` field
    assert(itab.info, "`info` field not found for '"..id.."'")
    -- check `fmt` field
    local fmt = itab.fmt
    if fmt then
        assert(type(fmt) == "table")
        local flag = false
        for k, f in pairs(fmt) do
            flag = true
            assert(type(k) == "string")
            assert(type(f) == "function")
        end
        assert(flag, "Empty format function table")
    end
    arch[id] = itab
    return self
end

function register:last_index()
    return #self._logList
end

-- add an `Info` object to the log output
-- the `Info` object will be installed if it is new
-- info = <info_id>|
--       { <info_id>|<info_object>, <fmt_id> [, param] }
-- index = nil|<integer> order position in the log
--
-- inner repr: {
--     {id_info, id_fmt, param, param, param, ...},
-- }
function register:add_to_log(info, index)
    local ll = self._logList
    local len = #ll
    local arch = self._iArchive
    local is_pos
    local log_entry = {} -- final data
    if type(info) == "string" then
        is_pos = self:_find_index(ll, info)
        log_entry[1] = info
    else
        assert(type(info) == "table")
        local id = info.id
        if id then -- info is a `Info` object
            self:install(info) -- check and install
            log_entry[1] = id
        else
            -- [index 1] expected a `Info` tab or a string
            local o = info[1]
            local id
            if type(o) == "string" then
                is_pos = self:_find_index(ll, o)
                log_entry[1] = o
                id = o
            else
                assert(type(o) == "table")
                self:install(o) -- check and install
                log_entry[1] = o.id
                id = o.id
            end
            -- format function?
            local id_fmt = info[2] -- name of the format function
            if id_fmt then
                assert(type(id_fmt) == "string")
                -- check if the fmt function exists
                local fmt_repo = arch[id].fmt
                if fmt_repo then
                    assert(fmt_repo[id_fmt])
                else
                    error("No format function available for '"..id.."' Info")
                end
                log_entry[2] = id_fmt
                local i = 3
                while info[i] do
                    log_entry[i] = info[i]
                    i = i + 1
                end
            end
        end
    end
    local id = log_entry[1]
    assert(arch[id], "`Info` id '"..id.."' not found")
    if is_pos == nil then -- insert or append
        if index then
            assert(type(index) == "number")
            assert(index >= 1 and index <= len + 1)
            table.insert(ll, index, log_entry)
        else
            ll[#ll + 1] = log_entry
        end
    else -- update an existing log entry
        if index then
            assert(type(index) == "number")
            assert(index >= 1 and index <= len)
            if not (index == is_pos) then
                local o = table.remove(ll, is_pos)
                table.insert(ll, index, o)
                is_pos = index
            end
        end
        local id_fmt = log_entry[2]
        local fmt_repo = arch[id].fmt
        if fmt_repo then
            if id_fmt then
                assert(fmt_repo[id_fmt], "format funcion '"..id_fmt.."' not found")
                local entry = ll[is_pos]
                entry[2] = id_fmt
                local i = 3
                while log_entry[i] do -- copy parameters
                   entry[i] = log_entry[i]
                   i = i + 1
                end
                entry[i] = nil -- safe breaking the parameters list
            else
                -- rise eventually a warning message
                -- "unuseful insertion call"
            end
        else
            error("Info '"..id.."' doesn't have any format function")
        end
    end
    return self
end

-- function register:set_format(id_fmt, ...)
-- TODO:
-- end

function register:remove_from_log(id_info)
    assert(type(id_info) == "string")
    local t = self._logList
    local i = assert(self:_find_index(t, id_info), id_info.." not found")
    table.remove(t, i)
    return self
end

function register:log()
    local tline = {}
    local arch = self._iArchive
    for pos, info in ipairs(self._logList) do
        local id = info[1]
        local iobj = assert(arch[id])
        local datalog = assert(iobj.info)
        if type(datalog) == "function" then
            datalog = assert(datalog(iobj))
        end
        datalog = assert(tostring(datalog))
        local id_fmt = info[2]
        if id_fmt then
            assert(type(id_fmt) == "string")
            local fn_fmt = assert(iobj.fmt[id_fmt], id_fmt.." field not found")
            assert(type(fn_fmt)=="function")
            datalog = fn_fmt(datalog, table.unpack(info, 3))
        end
        tline[#tline + 1] = {id, datalog}
    end
    return tline
end

-- private methods

-- init function
-- i_list = {<info_id>|{<info_id>|<info_object>, <fmt_id> [, param]}, ...}
function register:_define_or_default(i_list)
    i_list = i_list or self._default_log_entry_list
    assert(type(i_list) == "table")
    for _, logentry in ipairs(i_list) do
        self:add_to_log(logentry)
    end
    return self
end


function register:_find_index(t, id_name)
    local i = 1
    local res
    while t[i] do
        if t[i][1] == id_name then
            res = i
            break
        end
        i = i + 1
    end
    return res
end

-- `info` define and install code section

register:install{
    id = "EngineName",
    info = status.luatex_engine,
    fmt = {
        upper = function (engname)
            return engname:upper()
        end,
    }
}:install{
    id = "ElapsedTime",
    info = function(t)
        return tostring(os.clock() - t._start)
    end,
    _start = os.clock(),
    fmt = {
        mmss = function (et)
        
        end
    }
}:install{
    id = "JobName",
    info = tex.jobname or "unknow",
    fmt = {
        upper = function (j) return j:upper() end
    },
}:install{
    id = "FixedString", -- like comment or any other user defined text
    info = "",
    fmt = {
        set_message = function (_, text)
            assert(type(text) == "string")
            return text
        end,
    },
}:install{
    id = "FileSize",
    info = "10",
    --fmt = {},
}:install{
    id = "BuildDate",
    info = "date",
    --fmt = {},
}

-- define the log dataset if the user doesn't supply it with the init call
register._default_log_entry_list = {
    "JobName",     -- source file name
    "FileSize",    -- source file dimension
    "BuildDate",   -- build date and hour
    "ElapsedTime", -- build elapsed time
    "EngineName",  -- engine name
}

return lib
