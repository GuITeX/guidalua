---<<< prima_sol
local digit = {}
local n = 123321

local num = n
while num > 0 do
    digit[#digit + 1 ] = num % 10
    num = (num - num % 10) / 10
end

local sym_n, dec = 0, 1
for i=#digit,1,-1 do
    sym_n = sym_n + digit[i]*dec
    dec = dec * 10
end

print(sym_n == n)
--->>>

---<<< seconda_sol
local n = 123321

local num, sym_n, dec = n, 0, 1
while num > 0 do
    sym_n = sym_n + (num % 10)*dec
    dec = 10 * dec
    num = (num - num % 10) / 10
end
print(sym_n == n)
--->>>



