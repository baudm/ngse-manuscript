\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{manuscript}[2022/02/08 NGSE Manuscript]

\LoadClass[12pt,oneside]{book}
\RequirePackage[T1]{fontenc}

% --- Class Options: proposal, review, and double ---
\RequirePackage{etoolbox}
\newtoggle{proposal}  % Proposal version
\newtoggle{review}  % Review version
\newtoggle{double}  % Use double spacing
\DeclareOption{proposal}{\toggletrue{proposal}}
\DeclareOption{review}{\toggletrue{review}}
\DeclareOption{double}{\toggletrue{double}}
\DeclareOption*{\ClassWarning{manuscript}{Unknown option '\CurrentOption'}}
\ProcessOptions\relax

% --- Metadata ---
\input{metadata}
\title{\thesistitle}
\author{\student}
\date{\submissiondate}

% --- Page size and margins ---
\RequirePackage[margin=1in,\iftoggle{proposal}{a4}{left=1.5in,letter}paper]{geometry}

% --- Indents and spacing ---
\setlength{\parindent}{0.5in}  % Half-inch indents
\RequirePackage{indentfirst}  % Indent the first paragraph of a section
\RequirePackage[\iftoggle{double}{doublespacing}{onehalfspacing}]{setspace}  % Set line spacing globally

% --- Hyphenation and typesetting ---
\RequirePackage[english]{babel}
\RequirePackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100]{microtype}
\UseMicrotypeSet[protrusion]{basicmath}  % disable protrusion for tt fonts

% --- Fonts (load after babel) ---
\RequirePackage{newtxtext}  % Use Times Roman fonts
\RequirePackage{amsmath}
\RequirePackage{amsthm}  % FIXME: newtx 1.7 onwards has `amsthm` option
\RequirePackage{newtxmath}  % Use Times Roman compatible math fonts
\RequirePackage[zerostyle=d,straightquotes]{newtxtt}  % Enhancement of typewriter fonts

% --- General style tweaks ---
\RequirePackage[font=small,labelfont=it]{caption}  % Use small font, italicize caption label
% Combine chapter number and title in a single line
\RequirePackage{titlesec}
\titleformat{\chapter}[hang]{\normalfont\huge\bfseries}{\thechapter.}{20pt}{}
\pagestyle{plain}  % No headers; page numbers at bottom-center of page

% --- ToC tweaks ---
\addto\captionsenglish{\renewcommand{\contentsname}{Table of Contents}}  % Rename ToC
\RequirePackage{tocbibind}  % Add the ToC and bibliography (if using BibTeX) to the ToC

% --- Package Hooks: configure packages loaded by main.tex ---
\RequirePackage{afterpackage}
\AfterPackage{appendix}{%
    \appendixtitletocon  % Prepend 'Appendix ' to each listing in the ToC
}
\AfterPackage{biblatex}{%
    \setcounter{biburlnumpenalty}{9000}  % Make sure long URLs have line breaks
}
\AfterPackage{hyperref}{%
    \hypersetup{
    pdflang=en-PH,
    pdftitle=\mstitle,
    pdfauthor=\student,
    pdfkeywords=\keywords,
    pdfsubject=\degree,
    \iftoggle{review}{colorlinks}{hidelinks}  % color links for the review version
}}
\AfterPackage{cleveref}{%
    \crefname{section}{Sec.}{Secs.}
    \Crefname{section}{Section}{Sections}
    \crefname{table}{Tab.}{Tabs.}
    \Crefname{table}{Table}{Tables}
}

% --- \makeprelims command ---
\newcommand{\makeprelims}{%
\iftoggle{proposal}{%
    {\singlespacing\input{prelim_pages/title_proposal}}
}{%
    {\singlespacing
    \input{prelim_pages/title}
    \input{prelim_pages/univ_permission}
    \input{prelim_pages/approval}
    }
    \input{prelim_pages/acknowledgment}
}
\input{prelim_pages/abstract}
    {%
    \singlespacing
    \hypersetup{hidelinks}  % Hide links for these pages even for the review version
    \microtypesetup{protrusion=false}  % Disable protrusion
    \tableofcontents
    \listoftables
    \listoffigures
    }
}

% --- Line numbers for review ---
\iftoggle{review}{
\RequirePackage{lineno}
\RequirePackage{color}
\renewcommand{\linenumberfont}{\normalfont\footnotesize\sffamily\color[rgb]{.5,.5,1}}  % blue font color, larger font
\setlength\linenumbersep{1cm}  % wider separation
% Line numbers in both margins (adapted from: https://tex.stackexchange.com/a/199593)
\makeatletter
\renewcommand\makeLineNumberLeft{%
    \linenumberfont
    \llap{\hss\LineNumber\hskip\linenumbersep}  % left margin
    \hskip\columnwidth\hskip\linenumbersep
    \rlap{\hb@xt@\linenumberwidth{\hss\LineNumber}\hss}  % right margin
}
\makeatother
\leftlinenumbers  % Re-issue [left] option
\linenumbers
}{}

% --- Abbreviations (extracted from CVPR template) ---
% Add a period to the end of an abbreviation unless there's one already, then \xspace.
\RequirePackage{xspace}
\makeatletter
\DeclareRobustCommand\onedot{\futurelet\@let@token\@onedot}
\def\@onedot{\ifx\@let@token.\else.\null\fi\xspace}

\def\eg{\emph{e.g}\onedot} \def\Eg{\emph{E.g}\onedot}
\def\ie{\emph{i.e}\onedot} \def\Ie{\emph{I.e}\onedot}
\def\cf{\emph{cf}\onedot} \def\Cf{\emph{Cf}\onedot}
\def\etc{\emph{etc}\onedot} \def\vs{\emph{vs}\onedot}
\def\wrt{w.r.t\onedot} \def\dof{d.o.f\onedot}
\def\iid{i.i.d\onedot} \def\wolog{w.l.o.g\onedot}
\def\etal{\emph{et al}\onedot}
\makeatother

\endinput
