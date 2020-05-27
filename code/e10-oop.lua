

---<<< primo
-- prima tentativo di implementazione
-- di una classe rettangolo
Rectangle = {} -- creazione tabella (oggetto)

-- creazione dei due campi
Rectangle.width = 12
Rectangle.height = 7

-- un primo metodo assegnato direttamente
-- ad un campo della tabella
function Rectangle.area ()
   -- accesso alla variabile 'Rectangle'
   return Rectangle.larghezza * Rectangle.altezza
end

-- primo test
print(Rectangle.area())   --> stampa 84, OK
print(Rectangle.height)   --> stampa  7, OK
--->>>



---<<< due
-- ancora la prima implementazione
Rectangle = {width = 12, height = 7}

-- un metodo dell'oggetto
function Rectangle.area ()
   -- accesso alla variabile 'Rectangle' attenzione!
   local l = Rectangle.larghezza
   local a = Rectangle.altezza
   return l * a
end

-- secondo test
r = Rectangle   -- creiamo un secondo riferimento
Rectangle = nil -- distruggiamo il riferimento originale

print(r.width)     --> stampa 12, OK
print(r.area())    --> errore!
--->>>



---<<< tre
-- seconda implementazione
Rettangolo = {larghezza=12, altezza=7}

-- il metodo diviene indipendente dal particolare
-- riferimento all'oggetto:
function Rettangolo.area ( self )
   return self.larghezza * self.altezza
end

-- ed ora il test
myrect = Rettangolo
Rettangolo = nil -- distruggiamo il riferimento

print(myrect.larghezza)    --> stampa 12, OK
print(myrect.area(myrect)) --> stampa 84, OK
                           --      funziona!
--->>>




---<<< colon_notation
-- forma classica:
myrect.area(myrect)

-- forma implicita
-- e 'self' prende lo stesso riferimento di 'myrect'
myrect:area()
--->>>



---<<< tostring
-- un numero complesso
local complex = {real = 4, imag = -9}
print(complex) --> stampa: 'table: 0x9eb65a8'

-- un qualcosa di più utile: metatabella in sintassi
-- anonima con il metametodo __tostring()
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
-- una tabella con un campo 'a'
-- ma senza un campo 'b'
local t = {a = 'Campo A'}

print(t.a)  --> stampa 'Campo A'
print(t.b)  --> stampa 'nil'

-- con metatabella e metametodo
local mt = {
    __index = function ()
        return 'Attenzione: campo inesistente!'
    end
}

-- assegniamo 'mt' come metatabella di 't'
setmetatable(t, mt)

-- adesso riproviamo ad accedere al campo b
print(t.b)  --> stampa 'Attenzione: campo inesistente!'
--->>>




---<<< classe_rect
-- una nuova classe Rettangolo (campi):
local Rettangolo = {larghezza=10, altezza=10}

-- un metodo:
function Rettangolo:area()
  return self.larghezza * self.altezza
end

-- creazione metametodo
Rettangolo.__index = Rettangolo

-- un nuovo oggetto Rettangolo
local r = {}
setmetatable(r, Rettangolo)

print( r.larghezza ) --> stampa 10, Ok
print( r:area() )    --> stampa 100, Ok
--->>>



---<<< newrect
-- nuova classe Rettangolo (campi con valore di default)
local Rettangolo = {larghezza = 1, altezza = 1}

-- metametodo
Rettangolo.__index = Rettangolo

-- metodo di classe
function Rettangolo:area()
  return self.larghezza * self.altezza
end

-- costruttore di classe
function Rettangolo:new( o )
    -- creazione nuova tabella
    -- se non ne viene fornita una
    o = o or {}
    -- controllo campi
    if o.larghezza and o.larghezza < 0 then
        error("campo larghezza negativo")
    end
    if o.altezza and o.altezza < 0 then
        error("campo altezza negativo")
    end

    -- assegnazione metatabella
    setmetatable(o, self)

    -- restituzione riferimento oggetto
    return o
end

-- codice utente ------------------
local r = Rettangolo:new{larghezza=12, altezza=2}

print(r.larghezza)  --> stampa  12, Ok
print(r:area())     --> stampa  24, Ok

local q = Rettangolo:new{larghezza=12}
print(q:area())     --> stampa 12, Ok
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
   local o = {}
   if r then
      o.radius = r
   end
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
    self.weapon = w or ""
end

-- overriding method
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

