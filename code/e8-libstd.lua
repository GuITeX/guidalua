

---<<< one
print(math.pi)
print(math.sin( math.pi/2 ))
print(math.cos(0))

-- accorciamo i nomi delle funzioni ;-)
local pi, sin, cos = math.pi, math.sin, math.cos
local function one(a)
    local square = function (x) return x*x end
    return square(sin(a)) + square(cos(a))
end

for i=0, 1, 0.1 do
    print(i, one(i))
end
--->>>

---<<< fmt
-- "%d" means match a digit
local s1 = string.format("%d + %d = %d", 45, 54, 45+54)
print(s1)
local s2 = string.format("%06d", 456)
print(s2)

-- "%f" means float
local num = 123.456
local s3 = string.format(
    "intero %d e decimale %0.2f",
    math.floor(num),
    num
)
print(s3)

-- "%s" means string
print(string.format("s1='%s', s2='%s'", s1, s2))

print(string.format("%24s", "pippo"))
--->>>

---<<< pattern_one
-- semplice pattern in azione
local s = [[
le prime tre cifre decimali di \pi = 3,141592654 sono]]
local pattern = "%d%d%d"
print(string.match(s, pattern))
--->>>

---<<< pattern_two
-- occorrenza di un numero intero
-- come una o più cifre consecutive
print(string.match("l'intero 65 interno", "%d+"))
print(string.match("l'intero 0065 interno", "%d+"))

-- e per estrarre un numero decimale?
-- il punto è una classe così si utilizza
-- la classe '%.' per ricercare il carattere '.'
print(string.match("num = 45.12 :-)", "%d+%.%d+"))
--->>>

---<<< capture_one
-- extract only
local s = "This '10/03/2025' is a future date"
print(string.match(s, "%d%d/%d%d/(%d%d%d%d)"))
--->>>

---<<< capture_two
-- extract all
local s = "This '10/03/2025' is a future date"
local d, m, y = string.match(
    s,
    "(%d+%d?)/(%d%d)/(%d%d%d%d)"
)
print(d, m, y)
--->>>


---<<< gsub
local s = "The house is black."
print(string.gsub(s, "black", "red"))
print(string.gsub(s, "(%a)lac(%a)", "%2lac%1"))
--->>>


---<<< gsubfn
local s = "Cose da fare oggi 5, cosa da fare domani 2"
print(string.gsub(s, "%d+", function(n)
    return tonumber(n)*12
end))
--->>>

---<<< esercizio3
string.match("num = .123456 :-)", "%d+%.%d+")
--->>>




