
---<<< uno
-- produzione tabella con salto
local t = {45, 56, 89}
local i = 100 + #t -- 100 holes
for j, v in ipairs{12, 0, 2, -98} do
    t[i+j] = v
end
print("ipairs() table iteration test")
for index, elem in ipairs(t) do
    print(string.format("t[%3d] = %d", index, elem))
end
print()
print("pairs() table iteration test")
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
local iter_fn = iter(t)
while true do
    local val = iter_fn()
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
    -- valori iniziali delle variabili di ciclo
    local val = first + first % 2 - 2
    local i = 0
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
    print(string.format("iterazione %d -> %d", i, val))
end
--->>>


print ""

---<<< generic_for
-- even number stateless iterator
local function next_even(last, i)
   i = i + 2
   if i<=last then
      return i
   end
end
 
local function evenNum(a, b)
   return next_even, b, a + a % 2 - 2
end

-- run the 'generic for'
for n in evenNum(10, 20) do
    print(n)
end
--->>>

