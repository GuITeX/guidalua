![GitHub release (latest by date)](https://img.shields.io/github/v/release/GuITeX/guidalua?label=current%20version)
![GitHub Workflow Status (event)](https://img.shields.io/github/workflow/status/GuITeX/guidalua/Compile%20LuaLaTeX%20main%20file%20guidalua.tex)
![Lines of code](https://img.shields.io/tokei/lines/github/GuITeX/guidalua)
![GitHub issues](https://img.shields.io/github/issues/GuITeX/guidalua)
![License](https://img.shields.io/badge/licence-LPPL%20%3E%3D1.3-green)
![GitHub Repo stars](https://img.shields.io/github/stars/GuITeX/guidalua?style=social)

Guida al linguaggio Lua per LuaTeX
==================================

![logo della guida tematica su Lua per LuaTeX](logoguidalua.svg)

Questo repository contiene i sorgenti LaTeX della *Guida alla programmazione Lua
in LuaTeX*. La guida fa parte del progetto *Guide Tematiche* per la diffusione
di documentazione di alta qualità centrata su argomenti specifici, condotto dal
Gruppo Italiano di utilizzatori di TeX [www.guitex.org](http://www.guitex.org).

Le guide tematiche sono disponibili nella sezione documentazione del sito del
GuIT a [questo link](https://www.guitex.org/home/it/documentazione). In
particolare, il file PDF precompilato di questa guida su Lua per LuaTeX può
essere scaricato da questo
[link diretto](http://www.guitex.org/home/images/doc/GuideGuIT/guidalua.pdf).

Per sostenere questa iniziativa la cosa migliore è associarsi al GuIT
consultando [la pagina web delle tipologie di
socio](https://guitex.org/home/it/diventa-socio/associarsi-a-guit).

Contenuti
---------

La *Guida al linguaggio Lua per LuaTeX* è suddivisa in tre parti. Nella parte
prima alcuni *tutorial* offrono una prima rapida presentazione sugli impieghi
pratici di Lua nei documenti TeX con i capitoli sulla *calcolatrice* e la
*composizione automatica di tabelle* e molto altro.

Nella seconda parte sono trattate le basi del liguaggio Lua in modo del tutto
generale. Ogni fine capitolo contiene esercizi da svolgere mano a mano che si
procede nello studio per raggiungere rapidamente i propri obiettivi di
conoscenza.

Nella terza parte vengono presentati esempi applicativi in LuaTeX dove il codice
Lua risolve problemi specifici difficili da implementare con il tradizionale
linguaggio macro di (La)TeX, utili per imparare usi nuovi e avanzati dei
programmi di composizione tipografica TeX.

La guida non richiede una conoscenza approfondita della programmazione. Occorre
tuttavia saper impartire comandi da terminale e aver installato sul proprio
computer una distribuzione TeX recente per eseguire gli esercizi.

Collaborazione
--------------

Con l'intento di rendere lo sviluppo delle guide tematiche *collaborativo* è
stato creato questo repository. Chiunque può contribuirvi in particolare per
arricchire la sezione dedicata agli argomenti applicativi, con suggerimenti,
proposte di approfondimenti o correzione di refusi.

Contatti
--------

Se volete potete scrivermi all'indirizzo di posta elettronica:
giaconet dot mailbox at gmail dot com

Compilazione della guida
------------------------

Tutto il necessario per compilare la guida con LuaLaTeX è contenuto nel
repository. Per farlo occorre una distribuzione TeX abbastanza recente e
completa, per esempio una TeX Live 2020; una volta scaricato l'archivio del
codice la sequenza completa dei comandi di compilazione è:

```bash
lualatex --shell-escape guidalua
biber guidalua
lualatex --shell-escape guidalua
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
citati all'interno della guida nella sezione *Note finali*.

Buona lettura e Happy LuaTeXing!
