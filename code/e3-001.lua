
---<<< uno
local function do_many(fn, n)
    for i = 1, n or 1 do
        fn()
    end
end

local function print_five()
    print(5)
end

do_many(print_five)
do_many(print_five, 10)
do_many(function () print("---") end, 12)
--->>>



---<<< due
-- primo caso
local function foo()
    -- body
end
local t = {}
t.foo = foo

-- secondo caso
local t = {}
t.foo = function ()
    -- body
end

-- terzo caso con più funzioni
local t = {
    foo = function ()
        -- body
    end,   
    hoo = function ()
        -- body
    end,
}
--->>>



---<<< tre
-- per un massimo di 5 argomenti
local function add(...)
    local n1, n2, n3, n4, n5 = ...
    return n1 + n2 + (n3 or 0) + (n4 or 0) + (n5 or 0)
end

-- con tutti gli argomenti
local function add_many(...)
    local t = {...} -- collecting args in a table
    local sum = 0
    for i = 1, #t do
        sum = sum + t[i]
    end
    return sum
end

print(add(40, 20))
print(add_many(45, 48, 54, 56, -58, 20))
print(add(14, 15, 6), add_all(-89, 45))
--->>>



---<<< quattro
local function add_and_multiply(molt, ...)
    local t = {...}
    local sum = 0
    for i = 1, #t do
        sum = sum + t[i]
    end
    
    return molt * sum
end

print(add_and_multiply(10, 45.23, 48, 9.36, -8, -56.3))
--->>>

