-- filename: code/e1-001.lua
-- costruttore tabella (l'ultima virgola è opzionale)
-- i doppi trattini rappresentano un commento
-- come // lo sono per il C
local t = {
    12, 45, 67, 101,   3,
     2, 89, 36,   7,  99,
    88, 33, 17,  12, 203,
    46,  1, 19,  50, 456,
}

local c = 0 -- contatore
for i = 1, #t do
    if t[i] % 2 == 0 then
        c = c + 1
    end
end
print(c)