

---<<< primo
-- prima tentativo di implementazione
-- di una classe rettangolo
Rettangolo = {} -- creazione tabella (oggetto)

-- creazione dei due campi
Rettangolo.b = 12
Rettangolo.h = 7

-- un primo metodo assegnato direttamente
-- ad un campo della tabella
function Rettangolo.area ()
    -- accesso alla variabile 'Rettangolo'
    return Rettangolo.b * Rettangolo.h
end

-- primo test
print(Rettangolo.area()) --> stampa 84, OK
print(Rettangolo.h)      --> stampa  7, OK
--->>>


---<<< due
-- ancora la prima implementazione
Rettangolo = {b = 12, h = 7}

-- un metodo dell'oggetto
function Rettangolo.area ()
    -- accesso alla variabile 'Rettangolo' attenzione!
    local l = Rettangolo.b
    local a = Rettangolo.h
    return l * a
end

-- secondo test
r = Rettangolo   -- creiamo un secondo riferimento
Rettangolo = nil -- distruggiamo il riferimento originale

print(r.b)       --> stampa 12, OK
print(r.area())  --> errore!
-- attempt to index a nil value (global 'Rettangolo')
--->>>


---<<< tre
-- seconda implementazione
Rettangolo = {b=12, h=7}

-- il metodo diviene indipendente dal particolare
-- riferimento all'oggetto:
function Rettangolo.area(self)
   return self.b * self.h
end

-- e ora il test
myrect = Rettangolo
Rettangolo = nil -- distruggiamo il riferimento

print(myrect.b)            --> stampa 12, OK
print(myrect.area(myrect)) --> stampa 84, OK funziona!
--->>>




---<<< colon_notation
-- forma classica
myrect.area(myrect)

-- forma implicita, 'self' è lo stesso riferimento di 'myrect'
myrect:area()
--->>>



---<<< tostring
-- un numero complesso
local complex = {real = 4, imag = -9}
print(complex) --> stampa: 'table: 0x9eb65a8'

-- un qualcosa di più utile: metametodo __tostring()
-- in sintassi anonima
local mt = {}
mt.__tostring = function (c)
   local fmt = "(%0.2f, %0.2f)"
   return string.format(fmt, c.real or 0, c.imag or 0)
end

-- assegnazione della metatabella mt a complex
setmetatable(complex, mt)

-- riprovo la stampa
print(complex)  --> stampa '(4.00, -9.00)'
--->>>



---<<< index
-- una tabella con la chiave 'a' ma non 'b'
local t = {a = 'Campo A'}

print(t.a)  --> stampa 'Campo A'
print(t.b)  --> stampa 'nil'

-- con metatabella e metametodo
local mt = {
    __index = function (t, key)
        return 'Attenzione: campo "'..key..'" inesistente!'
    end
}
-- assegniamo 'mt' come metatabella di 't'
setmetatable(t, mt)

-- adesso riproviamo
print(t.a)  --> stampa 'Campo A'
print(t.b)  --> stampa 'Attenzione: campo "b" inesistente!'
--->>>




---<<< classe_rect
-- una nuova classe Rettangolo (campi):
local Rettangolo = {b=10, h=10}

-- un metodo:
function Rettangolo:area()
  return self.b * self.h
end

-- creazione metametodo
Rettangolo.__index = Rettangolo

-- un nuovo oggetto Rettangolo
local r = {}
setmetatable(r, Rettangolo)

print(r.b)      --> stampa 10, Ok
print(r:area()) --> stampa 100, Ok
--->>>



---<<< newrect
-- nuova classe Rettangolo (campi con valore di default)
local Rettangolo = {b = 1, h = 1}

-- metametodo
Rettangolo.__index = Rettangolo

-- metodo di classe
function Rettangolo:area()
    return self.b * self.h
end

-- costruttore di classe
function Rettangolo:new(o)
    -- creazione nuova tabella
    -- se non ne viene fornita una
    o = o or {}
    -- controllo campi
    if o.b and o.b < 0 then
        error("campo larghezza negativo")
    end
    if o.h and o.h < 0 then
        error("campo altezza negativo")
    end
    -- assegnazione metatabella
    setmetatable(o, self)
    -- restituzione riferimento oggetto
    return o
end

-- codice utente ------------------
local r1 = Rettangolo:new{b=12, h=2}
print(r1.b)       --> stampa  12, Ok
print(r1:area())  --> stampa  24, Ok

local r2 = Rettangolo:new{h=5}
print(r2.b)       --> stampa 1, Ok
print(r2:area())  --> stampa 5, Ok
--->>>



---<<< cerchio
local Cerchio = {radius=0}
Cerchio.__index = Cerchio

function Cerchio:area()
    return math.pi*self.radius^2
end

function Cerchio:addToRadius(v)
    self.radius = self.radius + v
end

function Cerchio:__tostring()
    local frmt = 'Sono un cerchio di raggio %0.2f.'
    return string.format(frmt, self.radius)
end

-- il costruttore attende l'eventuale valore del raggio
function Cerchio:new(r)
    local o = {radius = r}
    setmetatable(o, self)
    return o
end

-- codice utente ----------------------
local o = Cerchio:new()
print(o)  --> stampa 'Sono un cerchio di raggio 0.00'

o:addToRadius(12.342)

print(o)  --> stampa 'Sono un cerchio di raggio 12.34'
print(o:area())  --> stampa '478.54298786'
--->>>

---<<< sportivo
-- classe base
local Sportivo = {}

-- costructor
function Sportivo:new(t)
    t = t or {}
    setmetatable(t, self)
    self.__index = self
    return t
end

-- base methods
function Sportivo:set_name(name)
    self.name = name
end

function Sportivo:print()
    print("'"..self.name.."'")
end

-- derivazione
local Schermista = Sportivo:new()

-- specializzazione classe derivata
-- nuovo campo
Schermista.rank = 0

function Schermista:add_to_rank(points)
    self.rank = self.rank + (points or 0)
end

function Schermista:set_weapon(w)
    self.weapon = w
end

-- method overriding
function Schermista:print()
    local fmt = "'%s' weapon->'%s' rank->%d"
    print(
        string.format(
            fmt,
            self.name,
            self.weapon,
            self.rank
        )
    )
end

-- test
local s = Sportivo:new{name="Gianni"}
s:print() --> stampa 'Gianni' OK

-- il metodo costruttore new() è quella della classe base!
local f = Schermista:new{
    name="Tiger",
    weapon="Foil"
}
f:add_to_rank(45)

f:print() --> stampa 'Tiger' weapon->'Foil' rank->45

-- chiamata a un metodo della classe base
f:set_name("Amedeo")
f:print() --> stampa 'Amedeo' weapon->'Foil' rank->45
--->>>

