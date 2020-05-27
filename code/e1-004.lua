local n = 786478654
local digits
if n < 10 then
    digits = 1 -- attenzione non 'local digits = 1'
elseif n < 100 then
    digits = 2
elseif n < 1000 then
    digits = 3
elseif n < 10000 then
    digits = 4
elseif n < 100000 then
    digits = 5
elseif n < 1000000 then
    digits = 6
elseif n < 10000000 then
    digits = 7
elseif n < 100000000 then
    digits = 8
elseif n < 1000000000 then
    digits = 9
elseif n < 10000000000 then
    digits = 10
else -- fermiamoci qui...
    digits = 11
end

print(digits)