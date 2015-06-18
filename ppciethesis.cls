
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ppfeethesis}[2008/05/22 v0.96 PP FEE thesis class]
\ProvidesClass{ppciethesis}[2010/12/20 v0.961 PP CIE thesis class]

% v.0.961 Fix for hypertex with DVI problem
% v.0.96 Fix for setspace package: emulation of new memoir commands for older memoir packages (tetex).
% v.0.95 Fix for setspace package emulated by memoir, causing exceptions in MikTeX 2.5  
% v.0.94 Added "bachelor" option for bachelor theses. 
% v.0.93 Varioref is loaded prior to hyperref.

% Declare bachelor thesis switch.
\newif\if@ppbachelor\@ppbachelorfalse

%
% Declare default options and load base package (memoir).
%
\DeclareOption{bachelor}
   {\@ppbachelortrue}

\ExecuteOptions{a4paper,pl,12pt,oneside,final}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax
\LoadClass{memoir}

%
% Require additional packages
%
\RequirePackage{babel}
\newif\if@pppolish
\iflanguage{polish}{\@pppolishtrue}{\@pppolishfalse}

\if@pppolish
\selectlanguage{polish}
\addto\captionspolish{\renewcommand{\tablename}{Tabela}}


\RequirePackage{indentfirst}
\addto\captionspolish{\renewcommand{\bibname}{Literatura}}   % Force "Literatura" instead of "Bibliografia"

\else

\selectlanguage{english}
\fi
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{booktabs}


\ifpdf
	\DeclareGraphicsExtensions{.pdf,.png,.jpg}
\else
	\DeclareGraphicsExtensions{.eps}
\fi
\RequirePackage{fancyvrb}

%
% Configure Hyperref
%

\RequirePackage{url}
\RequirePackage{nameref}
\RequirePackage{varioref}

\ifpdf
        %\usepackage[pdftex,hypertex,unicode,linktocpage,bookmarks]{hyperref}
			\usepackage[pdftex,unicode,linktocpage,bookmarks]{hyperref}
\else
        \usepackage[hypertex,unicode,linktocpage,bookmarks]{hyperref}
\fi
\hypersetup{    
    pdffitwindow=true,
    bookmarksnumbered=true,
    bookmarksopen=true,
    colorlinks=true,
    pdfpagelayout=SinglePage,
    pdfpagemode=UseOutlines,
    pdfstartview=Fit,
    linkcolor=black,
    citecolor=black,
    anchorcolor=black,
    filecolor=black,
    menucolor=black,
    urlcolor=black,
    pdftitle={},
    pdfauthor={},
    pdfkeywords={}
}
\RequirePackage{memhfixc}

%
% Emulate setspace package for older versions of memoir.
%
\ifx\undefined\SingleSpacing
\RequirePackage{setspace}
\newcommand{\SingleSpacing}{\singlespacing}
\fi
\ifx\undefined\OnehalfSpacing
\newcommand{\OnehalfSpacing}{\onehalfspacing}
\fi

%
% Customize title page
%
\aliaspagestyle{title}{empty}
\date{}
\newcommand{\ppsupervisor}[1]{\def\@ppsupervisor{#1}}
\newcommand{\ppyear}[1]{\def\@ppyear{#1}}

\setlength{\droptitle}{0cm}

\renewcommand{\maketitlehooka}{%
\begin{center}
\if@pppolish
Politechnika Pozna\'nska\\Wydzia{\l} Elektryczny\\Instytut Automatyki i In\.{z}ynierii Informatycznej
\else
Poznan University of Technology\\Faculty of Electrical Engineering\\Institute of Control and Information Engineering
\fi\end{center}}

\pretitle{\vspace{2cm}\begin{center}%
\if@pppolish%
\if@ppbachelor Praca dyplomowa in\.{z}ynierska\else Praca dyplomowa magisterska\fi
\else
\if@ppbachelor Bachelor's thesis\else Master's thesis\fi
\fi\par\vspace{1cm}\Large\bfseries\MakeUppercase}
\posttitle{\end{center}}

\newcommand{\album}[1]{\unskip ,~#1}
\renewcommand{\and}{\\}

\renewcommand{\maketitlehookb}{\vspace{1cm}}

\renewcommand{\maketitlehookc}{\vfill\begin{center}
\if@pppolish
Promotor\\\@ppsupervisor
\else
Supervisor\\\@ppsupervisor
\fi\end{center}
\vspace{2cm}\begin{center}Pozna\'n, \@ppyear\if@pppolish~r.\fi\end{center}
}

%
% Define colophon 
%
\newcommand{\ppcolophon}{
\renewcommand{\and}{\unskip{}, }
\renewcommand{\album}[1]{\unskip}
\cleardoublepage\thispagestyle{empty}\vspace*{\fill}
\footnotesize\SingleSpacing\noindent
\raisebox{-1.3cm}{\includegraphics[height=1.5cm]{figures/template/logo-pp}}
\hspace{1.5em}
\begin{minipage}[t]{11cm}
\vglue 0pt\copyright{} \@ppyear\ \@author

\medskip\noindent%
\if@pppolish%
Instytut Automatyki i In\.{z}ynierii Informatycznej, Wydzia{\l} Elektryczny\\%
Politechnika Pozna\'nska%
\else%
Poznan University of Technology\\Faculty of Electrical Engineering\\Institute of Control and Information Engineering
\fi

\medskip\noindent%
\if@pppolish%
Sk{\l}ad przy u{\.z}yciu systemu \LaTeX{}.
\else%
Typeset using \LaTeX\ in Computer Modern.
\fi

\renewcommand{\and}{\unskip{} $\backslash$and }%
\medskip\noindent Bib\TeX{}:\\[1ex]
\tiny\texttt{%
@mastersthesis\{ key,\\
\hspace*{2em}author = "\@author",\\
\hspace*{2em}title = "\@title",\\
\hspace*{2em}school = "Poznan University of Technology",\\
\hspace*{2em}address = "Pozna\'n, Poland",\\
\hspace*{2em}year = "\@ppyear",\\
\}
}
\end{minipage}
}

%
% Customize running titles and page style.
%

\makepagestyle{ppfcmthesis}
\makeatletter
\newcommand{\@ppfcmthesismarks}{%
  \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{##1}{##1}}    % left mark & right marks
  \def\sectionmark##1{\markright{%
    \ifnum \c@secnumdepth>\z@
      \thesection. \ %
    \fi
    ##1}}
  \def\tocmark{\markboth{\contentsname}{}}
  \def\lofmark{\markboth{\listfigurename}{}}
  \def\lotmark{\markboth{\listtablename}{}}
  \def\bibmark{\markboth{\bibname}{}}
  \def\indexmark{\markboth{\indexname}{}}
}
\makepsmarks{ppfcmthesis}{\@ppfcmthesismarks}
\makeatother
\makeevenhead{ppfcmthesis}{\normalfont\small\textbf\rightmark}{}{}
\makeoddhead{ppfcmthesis}{}{}{\normalfont\small\textbf\rightmark}

\makeheadrule{ppfcmthesis}{\textwidth}{0.4pt}

\makeevenfoot{ppfcmthesis}{}{\thepage}{\normalfont\small\itshape}
\makeoddfoot{ppfcmthesis}{\normalfont\small\itshape}{\thepage}{}
%
% Customize Table of Contents
%
\setcounter{tocdepth}{3}
\maxtocdepth{subsubsection}
\maxsecnumdepth{subsection}

%
% Customize book style
%
% \tightlists
\pagestyle{ppfcmthesis}
\setstocksize{297mm}{210mm}
\settrimmedsize{297mm}{210mm}{*}
\settrims{0pt}{0cm}
\setlrmarginsandblock{3.5cm}{2.5cm}{*}
\setulmarginsandblock{2.5cm}{2.5cm}{*}
\setmarginnotes{6pt}{50pt}{\onelineskip}
\setheadfoot{\onelineskip}{2\onelineskip}
\setheaderspaces{*}{2\onelineskip}{*}
\OnehalfSpacing

\changecaptionwidth
\captionwidth{.9\linewidth}
\captionnamefont{\footnotesize\scshape}
\captiontitlefont{\footnotesize}

\newcommand{\fcmfcaption}[2][\@empty]{
\captionnamefont{\footnotesize\bfseries}%
\captiondelim{.~}
\captionstyle{}
\captiontitlefont{\footnotesize}
\ifx #1\@empty \caption{#2}\else \caption[#1]{#2}}

\newcommand{\fcmtcaption}[2][\@empty]{
\captionnamefont{\footnotesize\bfseries\hfill}%
\captiondelim{}
\captionstyle{\raggedleft\\}
\captiontitlefont{\footnotesize\normalfont}
\ifx #1\@empty \caption{#2}\else \caption[#1]{#2}}

\def\thesubsubsection {\thesubsection .\arabic{subsubsection}}

\checkandfixthelayout

%
% Macros 
%

% English
\newcommand{\termdef}[1]{\emph{#1}}
\newcommand{\acronym}[1]{\emph{\MakeUppercase{#1}}}

% Polish
\newcommand{\definicja}[1]{\termdef{#1}}
\newcommand{\akronim}[1]{\acronym{#1}}
\newcommand{\english}[1]{ang.~\emph{#1}}

% Table head
\newcolumntype{L}{c}\newcommand{\tabhead}[1]{\multicolumn{1}{L}{#1}}

% chapter style
% \usepackage{fourier} % or what ever 
% \usepackage[scaled=.92]{helvet}%. Sans serif - Helvetica 
\usepackage{color,calc} 
\newsavebox{\ChpNumBox} 
\definecolor{ChapBlue}{rgb}{0.00,0.5,1.0} 
% \definecolor{ChapBlue}{rgb}{0.3,0.3,0.3} 
\makeatletter 
\newcommand*{\thickhrulefill}{% 
\leavevmode\leaders\hrule height 1\p@ \hfill \kern \z@} 
\newcommand*\BuildChpNum[2]{% 
\begin{tabular}[t]{@{}c@{}} 
  \makebox[0pt][c]{#1\strut} \\[0.5ex] 
  \colorbox{ChapBlue}{% 
  \rule[-4em]{0pt}{0pt}% 
  \rule{1.5ex}{0pt}\color{white}{\rule[6pt]{0cm}{35pt}#2}\strut 
  \rule{1.0ex}{0pt}}% 
  \end{tabular}} 
  \makechapterstyle{BlueBox}{% 
  \renewcommand{\chapnamefont}{\large\scshape} 
  \renewcommand{\chapnumfont}{\Huge\bfseries} 
  \renewcommand{\chaptitlefont}{\raggedright\Huge\bfseries} 
  \setlength{\beforechapskip}{20pt} 
  \setlength{\midchapskip}{8pt} 
  \setlength{\afterchapskip}{20pt}
  \setlength{\baselineskip}{0pt} 
  \renewcommand{\printchaptername}{} 
  \renewcommand{\chapternamenum}{} 
  \renewcommand{\printchapternum}{% 
  \sbox{\ChpNumBox}{% 
  \BuildChpNum{\chapnamefont\@chapapp}% 
  {\chapnumfont\thechapter}}} 
  \renewcommand{\printchapternonum}{% 
  \sbox{\ChpNumBox}{% 
  \BuildChpNum{\chapnamefont\vphantom{\@chapapp}}% 
  {\chapnumfont\hphantom{\thechapter}}}} 
  \renewcommand{\afterchapternum}{} 
  \renewcommand{\printchaptertitle}[1]{% 
  \usebox{\ChpNumBox}\hfill 
  \parbox[t]{\hsize-\wd\ChpNumBox-1em}{% 
  \vspace{\midchapskip}% 
  \thickhrulefill\par 
  \chaptitlefont ##1\par}}% 
} 

