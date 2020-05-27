local long_text = [=[
Questo è il codice Lua da stampare:

local tab = {10, 20, 30}
local idx = {3, 2, 1}
print(tab[idx[1]]) -- ops due parentesi quadre

local long_text = [[ -- questo non potremo farlo...
    Testo lungo...
]]

Tutto chiaro?
In Lua le stringhe letterali nel codice
possono essere proprio letterali
senza caratteri di escape e senza
preoccupazioni sulla presenza di gruppi
di delimitazione di chiusura...
]=]

print(long_text)