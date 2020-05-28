Guida al linguaggio Lua per LuaTeX
==================================

![logo della guida tematica](logoguidalua.svg)

Questo repository contiene i sorgenti LaTeX della Guida tematica alla riga di
comando. La guida fa parte del progetto *Guide Tematiche* per la diffusione di
documentazione di alta qualità centrata su argomenti specifici sul sistema TeX,
condotto dal Gruppo Italiano di utilizzatori di TeX
[www.guitex.org](http://www.guitex.org).

Il materiale è disponibile nella sezione documentazione del sito del GuIT a
[questo link](https://www.guitex.org/home/it/documentazione).

Contribuite con suggerimenti e segnalazioni, oppure con proposte per nuovi
problemi da risolvere con Lua. Grazie!

Contenuti
---------

La *Guida al linguaggio Lua per LuaTeX* è suddivisa in due parti. Nella parte
prima sono trattate le basi del liguaggio e nella seconda vengono presentati
esempi applicativi dove il codice Lua risolve problemi specifici difficili da
implementare con il tradizionale linguaggio macro.

Ogni fine capitolo contiene esercizi proposti da svolgere mano a mano che si
procede nello studio e raggiungere rapidamente i propri obiettivi di conoscenza,
in particolare per imparare un uso avanzato dei programmi di composizione
tipografica del mondo TeX.

Collaborazione
--------------

Con l'intento di rendere lo sviluppo delle guide tematiche *collaborativo* è
stato creato questo repository. Chiunque può contribuirvi in particolare per
arricchire la sezione dedicata agli argomenti applicativi.

Compilazione dei sorgenti della guida
-------------------------------------

Tutto il necessario per compilare la guida con LuaLaTeX è contenuto nel
repository. Per farlo occorre una distribuzione TeX abbastanza recente, per
esempio una TeX Live 2020, e il seguente comando:

```bash
lualatex --shell-escape guidalua
```

Licenza
-------

La licenza è riportata nel file `LICENSE` nella directory principale del
progetto e nelle prime pagine della guida stessa.

Ringraziamenti
--------------

Ringrazio tutti quelli che hanno contribuito con suggerimenti, segnalazioni di
refusi, e idee alla *Guida al linguaggio Lua per LuaTeX*. Alcuni amici sono
citati all'interno della guida alla sezione *Ringraziamenti*.

Contatti
--------

Se volete potete scrivermi all'indirizzo di posta elettronica seguente: giaconet
dot mailbox at gmail dot com

Buona lettura!
