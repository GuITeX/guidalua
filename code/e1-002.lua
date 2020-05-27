local factors = {}
local n = 123456789

local div = 2
while n > 1 do
    if n % div == 0 then
        factors[#factors + 1] = div
        n = n / div
        while n % div == 0 do
            n = n / div
        end
    end
    div = div + 1
end

for i= 1, #factors do
    print(factors[i])
end