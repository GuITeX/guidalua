-- filename: app-reg/mod-history.lua
local register = {
    start = os.clock(),
    sep = ", ",
    filename = "history.log",
}
-- output function
function register:append(tline)
    local f = io.open(self.filename, "a+")
    local sep = self.sep
    f:write(table.concat(tline, sep))
    f:write(string.char(10))
    f:close()
end
-- main user fucntion
function register:log()
    local jobname = tex.jobname
    local jn_attr = lfs.attributes(jobname..".tex")
    local tline = {}
    if jn_attr then
        tline[1] = jobname..".tex"
        tline[2] = jn_attr.size
    else
        tline[1] = "unknow"
        tline[2] = "unknow"
    end
    tline[3] = os.date()
    tline[4] = os.clock() - self.start
    tline[5] = status.luatex_engine
    self:append(tline)
end
return register
