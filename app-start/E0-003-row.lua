-- filename: app-start/E0-003-row.lua
local Row = {}
Row.__index = Row
function Row:new(fn_next, start, stop, step)
    if not stop then
        start, stop = 1, start
    end
    local o = {
        fn_next = fn_next,
        start = start,
        stop = stop,
        step = step or 1
    }
    setmetatable(o, self)
    return o
end

function Row:next()
    local var = self.var
    if not var then
        var = self.start
    else
        var = var + self.step
    end
    if var <= self.stop then
        self.var = var
        local fn = self.fn_next
        fn(var, self)
        return true
    end
end

function Row:reset()
    self.var = nil
end

local row = Row:new(
    function (diam, r)
        local area = math.pi/4 * (diam/10)^2
        local weight = area * 0.7850
        r[1], r[2] = area, weight
    end, 10, 20, 2
)

while row:next() do
    print(row.var, row[1], row[2])
end
