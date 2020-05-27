

---<<< anchequesto
print "si è possibile anche questo..."

-- e questo:
local function is_empty(t)
    if #t == 0 then
        return true
    else
        return false
    end
end
print(is_empty{})
print(is_empty{1, 2, 3})

-- invece di questo (sempre possibile):
print(is_empty({}))
print(is_empty({1, 2, 3}))
--->>>


---<<< uno
local function new_counter()
    local i = 0 -- variabile nel contesto esterno
    return function ()
        i = i + 1 -- accesso alla closure
        return i
    end
end

local c1 = new_counter()
print(c1()) --> 1
print(c1()) --> 2
print(c1()) --> 3
print(c1()) --> 4
print(c1()) --> 5

local c2 = new_counter()
print(c2()) --> 1
print(c2()) --> 2
print(c2()) --> 3

print(c1()) --> 6
--->>>


---<<< due
local function sort_by_value(tab)
    local val = {
        [1994] = 12.5,
        [1996] = 10.2,
        [1998] = 10.9,
        [2000] =  8.9,
        [2002] = 12.9,
    }
    table.sort(tab,
        function (a, b)
            return val[a] > val[b]
        end
    )
end

local years = {1994, 1996, 1998, 2000, 2002}
sort_by_value(years)

for i = 1, #years do
    print(years[i])
end
--->>>


