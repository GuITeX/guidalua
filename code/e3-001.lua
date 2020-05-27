
---<<< uno
local function print_five()
    print(5)
end

local function do_many(fn, n)
    for i=1, n or 1 do
        fn()
    end
end

do_many(print_five)
do_many(print_five, 10)
do_many(function () print("---") end, 12)
--->>>



---<<< due
-- primo caso
local function tipo_i()
    -- body
end

local t = {}
t.func_1 = tipo_i

-- secondo caso
local t = {}
t.func_2 = function ()
    -- body
end

-- terzo caso con più di una funzione
local t = {
    func_3_i = function ()
        -- body
    end,
    
    func_3_ii = function ()
        -- body
    end,
    
    func_3_iii = function ()
        -- body
    end,
}
--->>>



---<<< tre
-- per un massimo di 3 argomenti
local function add_three(...)
    local n1, n2, n3 = ...
    return (n1 or 0) + (n2 or 0) + (n3 or 0)
end

-- con tutti gli argomenti
local function add_all(...)
    local t = {...} -- collecting args in a table
    local sum = 0
    for i = 1, #t do
        sum = sum + t[i]
    end
    return sum
end

print(add_three(40, 20))
print(add_all(45, 48, 5456))
print(add_three(14, 15), add_all(-89, 45.6))
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

