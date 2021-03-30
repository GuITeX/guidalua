%%
%% This is file `guidatematica.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% guidatematica.dtx  (with options: `class')
%%   ________________________________________
%%   The guidatematica class for typesetting books in the GuIT series
%%   "Guide Tematiche"
%%   Copyright (C) 2012-2019 GuIT,
%%      Gruppo utilizzatori Italiani di TeX e LaTeX
%%   All rights reserved
%% 
%%   https://www.guitex.org
%% 
%%   License information appended
%% 
\NeedsTeXFormat{LaTeX2e}[2009/01/01]
\ProvidesClass{guidatematica}%
   [2020-04-29 v.2.1.00 Classe simmetrica per comporre testi della collana
   Guide Tematiche del GuIT]
\AtBeginDocument{\@ifpackageloaded{hyperref}{\hypersetup{colorlinks,linkcolor={blue},
  citecolor={blue!80!black},urlcolor={blue}}}{}}

\newif\ifPAD\PADfalse
\DeclareOption{pad}{\PADtrue\tabletfalse\Aivfalse\Bvfalse\Avfalse}
\newif\iftablet\tabletfalse
\DeclareOption{tablet}{\tablettrue\Aivfalse\Bvfalse\Avfalse\PADfalse}
\newif\ifAiv \Aivfalse
\DeclareOption{a4paper}{\Aivtrue\tabletfalse\Bvfalse\Avfalse\PADfalse}
\newif\ifBv \Bvtrue
\DeclareOption{b5paper}{\Aivfalse\Bvtrue\tabletfalse\Avfalse\PADfalse}
\newif\ifAv \Avfalse
\DeclareOption{a5paper}{\Avtrue\Aivfalse\Bvfalse\tabletfalse\PADfalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions*\relax

\LoadClassWithOptions{memoir}
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  \RequirePackage[italian]{babel}
  \RequirePackage[tt={oldstyle=false,tabular,monowidth}]{cfr-lm}
\else
  \RequirePackage{fontspec}
  \defaultfontfeatures[\rmfamily,\sffamily]{Ligatures=TeX,Numbers=OldStyle}
  \defaultfontfeatures[\ttfamily,\tvfamily]{Numbers=Lining}
  \setmainfont{Latin Modern Roman}[SmallCapsFont={* Caps}]
  \setsansfont{Latin Modern Sans}
  \setmonofont{Latin Modern Mono}
  \newfontfamily{\tvfamily}{Latin Modern Mono Prop}
  \DeclareTextFontCommand{\texttm}{\ttfamily}
  \DeclareTextFontCommand{\texttv}{\tvfamily}
  \def\textl#1{{\addfontfeature{Numbers=Lining}#1}}
  \RequirePackage{unicode-math}
  \setmathfont{Latin Modern Math}
  \RequirePackage{polyglossia}
  \setmainlanguage[babelshorthands]{italian}
  \ifx\tmspace\@undefined
    \newlength{\tmspace}\tmspace=\z@
  \fi
\fi
\RequirePackage{graphicx}
\RequirePackage{metalogo}
\RequirePackage{pict2e}[2009/06/01]
\RequirePackage{microtype}
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage{multicol}
\RequirePackage{imakeidx}
\RequirePackage{fancyvrb}
\RequirePackage{afterpage}
\RequirePackage{enumitem}
\RequirePackage[right]{eurosym}
\RequirePackage{listings}
\lstloadlanguages{[LaTeX]TeX}
\normalfont
\ifPAD\setstocksize{160mm}{120mm}\fi
\iftablet\setstocksize{120mm}{90mm}\fi
\ifBv\setstocksize{250mm}{176mm}\fi
\ifAiv\setstocksize{297mm}{210mm}\fi
\ifAv\setstocksize{210mm}{146mm}\fi
\settrims{0pt}{0pt}

\settypeblocksize{\paperwidth}{\dimexpr\paperwidth*\paperwidth/\paperheight}{*}
\setlrmargins{*}{*}{*}
\setulmargins{*}{*}{*}
\setheadfoot{\baselineskip}{2\onelineskip}
\setheaderspaces{*}{\onelineskip}{*}
\setmarginnotes{7pt}{\dimexpr\foremargin-3em}{5pt}
\checkandfixthelayout[nearest]
\def\GetFileInfo#1{%
  \def\filename{#1}%
  \def\@tempb##1 ##2 ##3\relax##4\relax{%
    \def\filedate{##1}%
    \def\fileversion{##2}%
    \def\fileinfo{##3}}%
  \edef\@tempa{\csname ver@#1\endcsname}%
  \expandafter\@tempb\@tempa\relax? ? \relax\relax}
\let\@copymark\@empty % Di default è vuoto
\newcommand*\setcopymark[1]{\gdef\@copymark{#1}}
\newcommand*\@insertcopymark{%
  \begin{picture}(0,0)\unitlength=1pt\relax
  \if@twoside
    \ifodd\value{page}
            \put(\strip@pt\dimexpr\foremargin/2\relax,\strip@pt\footskip)%
            {\rotatebox{90}{\makebox(0,0)[l]{\@copymark}}}
    \else
            \put(-\strip@pt\dimexpr\foremargin/2\relax,\strip@pt\footskip)%
            {\rotatebox{90}{\makebox(0,0)[l]{\@copymark}}}
    \fi
  \else
            \put(\strip@pt\dimexpr\foremargin/2\relax,\strip@pt\footskip)%
            {\rotatebox{90}{\makebox(0,0)[l]{\@copymark}}}
  \fi
  \end{picture}%
}
\def\cblayoutsinistro{%
\dimen256=\dimexpr\headheight+\topmargin+1in-4pt-\paperheight\relax
\dimen258=\dimexpr\evensidemargin+1in\relax
\dimen262=1mm\relax
\dimen260=\dimexpr \paperwidth*\p@/\dimen262\relax
\dimen264=\dimexpr \paperheight-\topmargin-\headheight-1in
     -\headsep-\textheight\relax
\begin{picture}(0,0)(\strip@pt\dimen258,-\strip@pt\dimen256)%
\put(0,0){\unitlength=\p@
\put(0,0){\framebox(\strip@pt\paperwidth,\strip@pt\paperheight){}}%
\color{red}%
\put(\strip@pt\dimen258,\strip@pt\dimen264){%
    \framebox(\strip@pt\textwidth,\strip@pt\textheight){}}%
    \Line(0,0)(\strip@pt\paperwidth,\strip@pt\paperheight)%
    \put(\strip@pt\dimexpr\paperwidth/2\relax,%
        \strip@pt\dimexpr\dimen264+\textheight/2\relax)%
        {\circle{\strip@pt\paperwidth}}%
}
\end{picture}}

\def\cblayoutdestro{%
\dimen256=\dimexpr\headheight+\topmargin+1in-4pt-\paperheight\relax
\dimen258=\dimexpr\oddsidemargin+1in\relax
\dimen262=1mm\relax
\dimen260=\dimexpr \paperwidth*\p@/\dimen262\relax
\dimen264=\dimexpr \paperheight-\topmargin-\headheight-1in
    -\headsep-\textheight\relax
\begin{picture}(0,0)(\strip@pt\dimen258,-\strip@pt\dimen256)%
\put(0,0){\unitlength=\p@
\put(0,0){\framebox(\strip@pt\paperwidth,\strip@pt\paperheight){}}%
\color{red}%
\put(\strip@pt\dimen258,\strip@pt\dimen264){%
    \framebox(\strip@pt\textwidth,\strip@pt\textheight){}}%
    \Line(0,\strip@pt\paperheight)(\strip@pt\paperwidth,0)%
    \put(\strip@pt\dimexpr\paperwidth/2\relax,%
       \strip@pt\dimexpr\dimen264+\textheight/2\relax)%
       {\circle{\strip@pt\paperwidth}}%
}
\end{picture}}
\providecommand*\Ars{%
  \textsf{\lower -.48ex\hbox{\rotatebox{-20}{A}}\kern -.3em{rs}}\hskip0pt%
  \kern -.05em\TeX\hskip0pt\kern -.17em\lower -.357ex\hbox{nica}}

\AtBeginDocument{\let\originaltitle\title
\renewcommand\title[1]{%
\def\@@title{{\let\\\ \normalfont\normalsize#1}}\originaltitle{#1}}
\let\originalauthor\author
\renewcommand\author[2][\Large]{\def\@@author{#2}\originalauthor{{#1#2}}}
\def\@@Copyright{}
\DeclareRobustCommand\Copyright[1]{\edef\@@Copyright{#1}}
\let\originalmaketitle\maketitle
\renewcommand\maketitle{\frontmatter*\originalmaketitle
\contribguit}}

\let\@licenza\voidbox
\newcommand\licenza[1]{\long\gdef\@licenza{#1}}

\newcommand{\contribguit}{\newpage
\thispagestyle{empty}
\noindent{\Large
Associati anche tu al \GuIT
\hfill
\setlength{\unitlength}{1mm}
 \begin{picture}(50,2)
  \setlength{\fboxsep}{0pt}
  \put(1,-3){\colorbox{gray}{\framebox(50,6.5){}}}
  \put(0,-2){\colorbox{white}{\framebox(50,6.5){%
   \href{https://www.guitex.org/home/it/diventa-socio/associarsi-a-guit}{%
    Fai click per associarti}}}}
 \end{picture}%
}
\bigskip

L'associazione per la diffusione di \TeX\ in Italia, riconosciuta
ufficialmente in ambito internazionale, si sostiene \emph{unicamente}
con le quote sociali.

Se anche tu trovi che questa guida tematica gratuita ti sia stata utile,
il mezzo principale per ringraziare gli autori è diventare socio.
\medskip

Divenendo soci si ricevono gratuitamente:
\begin{itemize}
\item
l'abbonamento alla rivista \Ars;
\item
il DVD \TeX\ Collection;
\item
un eventuale oggetto legato alle attività del \GuIT.
\end{itemize}

L'adesione al \GuIT\ prevede un quota associativa compresa tra \EUR{12,00}
e \EUR{70,00} a seconda della tipologia di adesione prescelta e ha
validità per l'anno solare in corso.

\vspace{\stretch{1}}
\providecommand\authorspace{ }
{\parindent=\z@\let\authorspace\ %
\ifx\@licenza\voidbox
\noindent\@@title\\
Copyright \textcopyright\ \ifcsvoid{@@Copyright}{\the\year}{\@@Copyright}, %
  \@@author\\[\baselineskip]
  Questa documentazione è soggetta alla licenza LPPL (\LaTeX\ Project
  Public Licence), versione 1.3 o successive; il testo della licenza è
  sempre contenuto in qualunque distribuzione del sistema \TeX\ e nel
  sito \url{http://www.latex-project.org/lppl.txt}.\\[\baselineskip]
  Questo documento è curato da \@@author.
\else
  \@licenza
\fi\par}
\newpage
}
\nouppercaseheads
\renewcommand{\footruleskip}{0pt}
\makeheadrule{headings}{\textwidth}{0pt}
\makeheadrule{myheadings}{\textwidth}{0pt}
\makeevenfoot{plain}{\@insertcopymark}{\textsc{\thepage}}{}
\makeoddfoot{plain}{}{\textsc{\thepage}}{\@insertcopymark}
\makeevenfoot{headings}{\@insertcopymark}{\textsc{\thepage}}{}
\makeoddfoot{headings}{}{\textsc{\thepage}}{\@insertcopymark}
\makeevenfoot{myheadings}{\@insertcopymark}{\textsc{\thepage}}{}
\makeoddfoot{myheadings}{}{\textsc{\thepage}}{\@insertcopymark}
\makeevenhead{headings}{}{\textsc{\small\leftmark}}{}
\makeoddhead{headings}{}{\textsc{\small\rightmark}}{}
\makeevenhead{myheadings}{}{\textsc{\small\leftmark}}{}
\makeoddhead{myheadings}{}{\textsc{\small\rightmark}}{}
\makepsmarks{headings}{%
\createmark{chapter}{both}{shownumber}{\@chapapp\space}{.\qquad}
\createmark{section}{right}{shownumber}{$\mathsection$\,}{\qquad}
\renewcommand*\indexmark{\markboth{\indexname}{\indexname}}}
\makepagestyle{headingslayout}
\makeevenhead{headingslayout}{\cblayoutsinistro}{\textsc{\small\leftmark}}{}
\makeevenfoot{headingslayout}{\@insertcopymark}{\textsc{\thepage}}{}
\makeoddhead{headingslayout}{\cblayoutdestro}{\textsc{\small\rightmark}}{}
\makeoddfoot{headingslayout}{}{\textsc{\thepage}}{\@insertcopymark}
\makechapterstyle{guidatematica}{%
   \renewcommand*{\chapnumfont}{%
      \fontshape{it}\fontsize{40}{40}\selectfont}
   \renewcommand*{\printchaptername}{}
   \renewcommand*{\chapternamenum}{}
   \renewcommand*{\chaptitlefont}{%
       \fontsize{18}{16}\scshape}% sterlineato
   \renewcommand{\printchapternum}{%
       \noindent\rlap{\makebox[\textwidth][r]{%
         \rlap{\makebox[\foremargin][l]{%
       \chapnumfont \thechapter}}}}\printchaptertitle}
   \renewcommand*{\afterchapternum}{}
}
\AtBeginDocument{\chapterstyle{guidatematica}}
\renewcommand*\partnamefont{\normalfont\large\scshape}
\renewcommand*\partnumfont{\normalfont\large\scshape}
\renewcommand*\parttitlefont{\normalfont\huge\scshape}
\setbeforesecskip{-3.5ex plus-1ex minus-0.2ex}
\setbeforesubsecskip{-3ex plus-1ex minus-0.2ex}
\setbeforesubsubsecskip{-2.5ex plus-1ex minus-0.2ex}
\setbeforeparaskip{1\onelineskip plus1ex minus0.2ex}
\setbeforesubparaskip{1\onelineskip plus1ex minus0.2ex}
\setaftersecskip{1.5ex plus0.2ex}
\setaftersubsecskip{1.5ex plus0.2ex}
\setaftersubsubsecskip{1.5ex plus0.2ex}
\setafterparaskip{-1em}
\setaftersubparaskip{-1em}
\setsubparaindent{\parindent}

\setsecheadstyle{\large\scshape\raggedright}
\setsubsecheadstyle{\large\scshape\raggedright}
\setsubsubsecheadstyle{\large\scshape\raggedright}
\setparaheadstyle{\small\scshape}
\setsubparaheadstyle{\small\scshape}

\aliaspagestyle{part}{empty}
\aliaspagestyle{chapter}{empty}
\copypagestyle{titlepage}{headings}
\renewcommand\cftpartpagefont{\scshape}
\renewcommand\cftpartfont{\large\scshape}
\renewcommand\cftchapterfont{\large\scshape}
\renewcommand\cftchapterpagefont{\scshape}
\renewcommand*{\cftchapterfillnum}[1]{%
    {\cftchapterleader}\nobreak
    \cftchapterformatpnum{#1}%
    \cftchapterafterpnum\par\nobreak}
\setlength{\cftbeforechapterskip}{1.0em \@plus 2\p@}
\captiondelim{\quad}
\captionnamefont{\small\scshape}
\captiontitlefont{\small}
\captionstyle[\centering]{}
\hangcaption
\captionwidth{\dimexpr\textwidth-2\parindent\relax}\changecaptionwidth
\renewcommand\descriptionlabel[1]{\hspace\labelsep\normalfont\scshape #1}
\renewcommand\blockdescriptionlabel[1]{\normalfont\scshape #1}
\providecommand\plaindescriptionlabel[1]{\hspace\labelsep\normalfont #1}

\renewlist{blockdescription}{description}{1}
\setlist[blockdescription]{before={\let\makelabel\blockdescriptionlabel},
leftmargin=\z@,labelsep*=0.5em,labelindent=\z@,labelwidth=\z@}

\newlist{plaindescription}{description}{1}
\setlist[plaindescription]{before={\let\makelabel\plaindescriptionlabel}}

\newlist{compactenumerate}{enumerate}{1}
\setlist[compactenumerate,1]{label=\arabic*.,
   noitemsep, partopsep=\z@, topsep=.25\onelineskip}

\newlist{compactitemize}{itemize}{4}
\setlist[compactitemize]{label=•,
   noitemsep,partopsep=\z@,topsep=.25\onelineskip}

\newlist{compactdescription}{description}{1}
\setlist[compactdescription]{%
style=sameline,noitemsep,partopsep=\z@,topsep=.25\onelineskip}
\newcommand*\cambiacorpo[2][1.2]{\bgroup\dimen@=#2\p@\dimen@=#1\dimen@
\edef\x{\noexpand\egroup\noexpand\fontsize{#2}{\strip@pt\dimen@}}\x\selectfont}
\let\setfontsize\cambiacorpo
\AtBeginDocument{\setsecnumdepth{subsection}
   \settocdepth{subsection}\maxsecnumdepth{subsection}
   \maxtocdepth{subsection}}
\unless\ifcsname virgoladecimale\endcsname
\unless\ifPDFTeX
 \AtBeginDocument{\ifcsstring{xpg@main@language}{english}{\relax}{%
    \mathcode`\,=\string"8000}%
     \DeclareMathSymbol{\virgola}{\mathpunct}{letters}{"3B}%
     \DeclareMathSymbol{\virgoladecimale}{\mathord}{letters}{"3B}%
}
\else
 \AtBeginDocument{\ifcsstring{languagename}{english}{\relax}{%
    \mathcode`\,=\string"8000}}
\fi
{\catcode `,=\active \gdef,{\futurelet\let@token\m@thcomma}}%
\AtEndPreamble{%
\gdef\m@thcomma#1{%
\unless\ifcat\noexpand\let@token*%
  \virgola
\else
  \expandafter\expandafter\expandafter
      \ifcsname\expandafter\@gobble\string#1\endcsname
    \virgola
  \else
    \ifnum`#1<`0\relax
      \virgola
    \else
      \ifnum`#1>`9\relax
        \virgola
      \else
        \virgoladecimale
      \fi
    \fi
  \fi
\fi#1}%
}\fi
\AtEndPreamble{%
\providecommand\IntelligentComma{}
\providecommand\NoIntelligentComma{}
\renewcommand\IntelligentComma{\mathcode`\,=\string"8000}
\renewcommand\NoIntelligentComma{\mathcode`\,=\string"613B}
}
\let\imki@idxprologue\empty
\def\imki@columns{2}
\renewenvironment{theindex}
{%
  \clearforchapter
    \csname phantomsection\endcsname
    \chapter{\indexname}%
    \indexmark%
    \parindent\z@
    \parskip\z@ \@plus .3\p@\relax
    \let\item\@idxitem
    \begin{multicols}{\imki@columns}[\imki@idxprologue]
    \raggedright
}
{%
    \end{multicols}\gdef\imki@idxprologue{}\clearpage
}
% the next line was excluded because in conflict with biber/biblatex
%\AtBeginDocument{\bibliographystyle{guidatematica}}%
\unless\ifPDFTeX
   \ifcsstring{xpg@main@language}{italian}%
     {\csgappto{init@extras@italian}{\nofrench@indent}}{}%
\fi
\newenvironment{titlepage}{\clearpage
\pagestyle{titlepage}
    \makeoddhead{titlepage}{}{\smash{{\Large\scshape\@author}}}{}
    \makeoddfoot{titlepage}{}{\smash{{\large\scshape\@date}}}{}
}{\clearpage}

\providecommand\subtitle[1]{\gdef\@subtitle{#1}}
\let\@subtitle\empty

\renewcommand\maketitle{
    \begin{titlepage}
    \vspace*{\stretch{.7}}
    {\centering\LARGE\scshape\@title\par}
    \ifdefvoid{\@subtitle}{}{\vspace{2\onelineskip}
    {\centering\scshape\Large\@subtitle\par}}
    \vspace{\stretch{.7}}
    {\centering\resizebox{0.23\textwidth}{!}{\logoguittondo}\par}
    \vspace*{\stretch{.7}}
    \end{titlepage}
}
\newenvironment{medaglione}[1][\linewidth]{%
    \begin{lrbox}{0}%
    \begin{minipage}{\dimexpr#1-2\fboxsep-2\fboxrule}
}{%
    \end{minipage}\end{lrbox}\fbox{\usebox{0}}\relax
}

\newenvironment{sintassi}{\flushleft\medaglione}%
   {\endmedaglione\endflushleft}
\newcommand*\hz{\nobreak\hskip\z@}
\renewcommand*\meta[1]{\textnormal{$\langle$\textit{\hz#1}$\rangle$}}
\renewcommand*\marg[1]%
  {\textnormal{\texttt{\char123}\meta{#1}\texttt{\char125}}}
\renewcommand*\oarg[1]{\textnormal{\texttt{[}\meta{#1}\texttt{]}}}
\newcommand*\Arg[1]{\textnormal{\texttt{\{#1\}}}}
\let\Marg\Arg
\newcommand*\Oarg[1]{\textnormal{\texttt{[#1]}}}
\def\GT@splitargs#1,#2!{\def\@tempA{#1}\def\@tempB{#2}}
\newcommand\garg[1]{\textnormal{\GT@splitargs#1!\texttt{(}\meta{\@tempA}%
   \texttt{,}\meta{\@tempB}\texttt{)}}}
\newcommand*\comando[1]{\textnormal{\texttt{\string#1}}}
\renewcommand*{\cs}[1]%
{\textnormal{\texttt{\char92#1}\index{#1@\texttt{\char92#1}|textsc}}}
\let\csindex\cs
\newcommand*\Sambiente[2]{\comando{\begin}\marg{#1}\oarg{#2}\,\dots
   \comando{\end}\marg{#1}}
\newcommand*\Dambiente[3]{%
   \comando{\begin}\marg{#1}\oarg{#2}\oarg{#3}\,\dots
   \comando{\end}\marg{#1}}
\newcommand*\Bambiente[1]{\comando{\begin}\Marg{#1}}
\newcommand*\Eambiente[1]{\comando{\end}\Marg{#1}}
\DeclareRobustCommand*\ambstyle[1]{{\normalfont\textsf{\slshape#1}}}
\DeclareRobustCommand*\classstyle[1]{{\normalfont\texttv{\itshape#1}}}
\DeclareRobustCommand*\filestyle[1]{{\normalfont\texttm{\textl{#1}}}}
\DeclareRobustCommand*\packstyle[1]{{\normalfont
   \texttm{\ifbool{PDFTeX}{\textl}{\itshape}{#1}}}}
\DeclareRobustCommand*\progstyle[1]{{\normalfont\textsf{#1}}}
\DeclareRobustCommand*\prog[1]{\progstyle{#1}%
   \index{programma!#1@\progstyle{#1}|textsc}}
\DeclareRobustCommand*\pack[1]{\packstyle{#1}%
   \index{pacchetto!#1@\packstyle{#1}|textsc}}
\DeclareRobustCommand*\class[1]{\classstyle{#1}%
   \index{classe!#1@\classstyle{#1}|textsc}}
\DeclareRobustCommand*\file[1]{\filestyle{#1}%
   \index{file!#1@\filestyle{#1}|textsc}}
\DeclareRobustCommand*\amb[1]{\ambstyle{#1}%
   \index{ambiente!#1@\ambstyle{#1}|textsc}}
\DeclareRobustCommand*\opzstyle[1]{{\normalfont\textsl{\textl{#1}}}}
\DeclareRobustCommand*\contastyle[1]{{\normalfont\texttm{#1}}}
\DeclareRobustCommand*\stilestyle[1]{{\normalfont\texttm{#1}}}
\DeclareRobustCommand*\numeristyle[1]{{\normalfont\texttm{#1}}}
\DeclareRobustCommand*\umisurastyle[1]{{\normalfont\texttm{#1}}}
\DeclareRobustCommand*\chiavestyle[1]{{\normalfont\texttm{#1}}}
\DeclareRobustCommand*\descrittorestyle[1]{{\normalfont\texttm{#1}}}
\DeclareRobustCommand*\posizionestyle[1]{{\normalfont\texttm{#1}}}
\DeclareRobustCommand*\allineamentostyle[1]{{\normalfont\texttm{#1}}}
\DeclareRobustCommand*\opz[1]{\opzstyle{#1}%
   \index{opzione!#1@\opzstyle{#1}|textsc}}
\DeclareRobustCommand*\conta[1]{\contastyle{#1}%
   \index{contatore!#1@\contastyle{#1}|textsc}}
\DeclareRobustCommand*\stile[1]{\stilestyle{#1}%
   \index{stile della pagina!#1@\stilestyle{#1}}}
\DeclareRobustCommand*\numeri[1]{\numeristyle{#1}%
   \index{numerazione!#1@\numeristyle{#1}|textsc}}
\DeclareRobustCommand*\umisura[1]{\umisurastyle{#1}%
   \index{unit\`a di misura!#1@\umisurastyle{#1}|textsc}}
\DeclareRobustCommand*\chiave[1]{\chiavestyle{#1}%
   \index{chiave!#1@\chiavestyle{#1}|textsc}}
\DeclareRobustCommand*\descrittore[1]{\descrittorestyle{#1}%
   \index{descrittore di colonna!#1@\descrittorestyle{#1}|textsc}}
\DeclareRobustCommand*\posizione[1]{\posizionestyle{#1}%
   \index{posizione degli oggetti flottanti!#1@\posizionestyle{#1}|textsc}}
\DeclareRobustCommand*\allineamento[1]{\allineamentostyle{#1}%
   \index{codice di allineamento!#1@\allineamentostyle{#1}|textsc}}
\definecolor{verdeguit}{rgb}{0, 0.40, 0}
\def\GuIT{\mbox{\color{verdeguit}%
\ifPDFTeX\usefont{T1}{lmr}{m}{sc}%
  g\raisebox{-0.715ex}{\kern-0.26em u}\kern-0.13em
  \textcolor{black}{I}\kern-0.14em t%
\else\usefont{TU}{lmr}{m}{sc}%
  g\raisebox{-0.60ex}{\kern-0.285em u}\kern-0.14em
  \textcolor{black}{I}\kern-0.14em t%
\fi}}

\usepackage{tikz}
\usetikzlibrary{decorations.text}

\def\logoguittondo{\begin{tikzpicture}[x=1.65em,y=1.65em]\small
\draw  (0,-0.15) node [circle] {\Huge\GuIT};
\path[decorate,decoration={text along path, text={Gruppo Utilizzatori}}]
    (-1.5,0) .. controls (-1.5,2) and (1.5,2) .. (1.5,0);
\path[decorate,decoration={text along path, text={{\kern.25em}{$\star$}
{$\star$} Italiani di {\TeX} {$\star$} {$\star$}}}]
    (-1.8,0) .. controls (-1.8,-2.4) and (1.8,-2.4) .. (1.8,0);
\end{tikzpicture}
}
\newenvironment{pdfxmetadata}{%
\VerbatimOut{\jobname.xmpdata}}{\endVerbatimOut}

%% ƒ
%% Copyright 2012, 2013-2019 GuIT,
%%    Gruppo utilizzatori Italiani di TeX e LaTeX
%% 
%%   Distributable under the LaTeX Project Public License,
%%   version 1.3c or higher (your choice). The latest version of
%%   this license is at: http://www.latex-project.org/lppl.txt
%% 
%%   This Work has the status of `maintained'
%% 
%%   The Current Maintainer is the GuIT staff
%% 
%%   This work consists of this file guidatematica.dtx,
%%   and the derived files guidatematica.cls and guidatematica.pdf
%%   plus the associated documentation guidatematica-doc.tex
%%   and guidatematica-doc.pdf.
%% 
%%
%% End of file `guidatematica.cls'.
