
---<<< uno
-- produzione tabella con salto
local t = {45, 56, 89}
local i = 100 + #t -- 100 holes
for _, v in ipairs({12, 0, 2, -98}) do
    t[i] = v
    i = i + 1
end

print("ipairs() table iteration test")
for index, elem in ipairs(t) do
    print(string.format("t[%3d] = %d", index, elem))
end

print("\npairs() table iteration test")
for key, val in pairs(t) do
    print(string.format("t[%3d] = %d", key, val))
end
--->>>


---<<< due
-- costructor
local t = {45, 87, 98, 10, 16}

function iter(t)
    local i = 0
    return function ()
        i = i + 1
        return t[i]
    end
end

-- utilizzo
local iter_test = iter(t)
while true do
    local val = iter_test()
    if val == nil then
        break
    end
    print(val)
end
--->>>

print ""

---<<< tre
-- costructor
local t = {45, 87, 98, 10, 16}

function iter(t)
    local i = 0
    return function ()
        i = i + 1
        return t[i]
    end
end

-- utilizzo con il generic for
for v in iter(t) do
    print(v)
end
--->>>

print ""

---<<< iter_even
-- iteratore dei numeri pari compresi
-- nell'intervallo [first, last]
function evenNum(first, last)
    -- primo numero pari della sequenza
    local val = 2*math.ceil(first/2) - 2
    local i = 0 -- indice
    return function ()
        i = i + 1
        val = val + 2
        if val<=last then
            return val, i -- due variabili di ciclo
        end
    end
end

-- iterazione con due variabili di ciclo
for val, i in evenNum(13,20) do
    print(string.format("[%d] %d", i, val))
end
--->>>


print ""

---<<< generic_for
-- even numbers stateless iterator
local function nextEven(last, i)
   i = i + 2
   if i<=last then
      return i
   end
end
 
local function evenNum(a, b)
   local start = 2*math.ceil(a/2)-2
   return nextEven, b, start
end

-- example of the 'generic for' cycle
for n in evenNum(10, 20) do
    print(n)
end
--->>>

