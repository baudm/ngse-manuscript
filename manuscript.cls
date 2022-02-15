% Copyright 2022 Darwin Bautista
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%     https://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{manuscript}[2022/02/12 NGSE Manuscript]

% listof=totoc: add List of Tables, Figures to ToC
% captions=tableheading: adjusts the caption spacing of tables (placed above)
\LoadClass[12pt,oneside,listof=totoc,captions=tableheading]{scrbook}

% --- Class Options ---
\RequirePackage{etoolbox}
\newtoggle{onehalfspacing}
\newtoggle{review}
\newtoggle{proposal}
% Use 1.5 line spacing
\DeclareOption{onehalfspacing}{\toggletrue{onehalfspacing}}
% Review version. Show line numbers and timestamp title page.
\DeclareOption{review}{\toggletrue{review}}
% Proposal version
\DeclareOption{proposal}{\toggletrue{proposal}}
% Customized biblatex styles
\DeclareOption{ieee}{\PassOptionsToPackage{bibstyle=ieee,citestyle=numeric-comp,sorting=nty,dashed=false}{biblatex}}
\DeclareOption{apa}{%
    \PassOptionsToPackage{style=apa}{biblatex}
    \AfterPackage{biblatex}{\setlength\bibitemsep{0.3\baselineskip}}  % add a bit of separation between bib items
}
% Expose some options of the book/scrbook class
\DeclareOption{draft}{\PassOptionsToClass{draft}{scrbook}}
\DeclareOption{fleqn}{\PassOptionsToClass{fleqn}{scrbook}}
\DeclareOption{leqno}{\PassOptionsToClass{leqno}{scrbook}}
\DeclareOption*{\ClassWarning{manuscript}{Unknown option '\CurrentOption'}}
\ProcessOptions\relax

% --- Metadata ---
\input{manuscript-meta}
\title{\Title}
\author{\Student}
\date{\SubmissionDate}
\PassOptionsToPackage{pdflang=en-PH,pdftitle={\Title},pdfauthor={\Student},pdfkeywords={\Keywords},pdfsubject={\Degree}}{hyperref}
% Infer manuscript type from the degree. FIXME: comparison should be case-insensitive
\RequirePackage{xstring}
\IfBeginWith{\Degree}{Master}{\newcommand\Type{Thesis}}{\newcommand\Type{Dissertation}}

% --- Page size and margins ---
\RequirePackage[margin=1in,footskip=0.6in,\iftoggle{proposal}{a4}{left=1.5in,letter}paper]{geometry}

% --- Indents and line spacing ---
\setlength{\parindent}{0.5in}  % Half-inch indents
\RequirePackage{indentfirst}  % Indent the first paragraph of a section
\RequirePackage[\iftoggle{onehalfspacing}{onehalfspacing}{doublespacing}]{setspace}  % Set line spacing globally

% --- Hyphenation and typesetting ---
\RequirePackage[english]{babel}
\RequirePackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100]{microtype}
\UseMicrotypeSet[protrusion]{basicmath}  % disable protrusion for tt fonts

% --- Fonts (load after babel) ---
\RequirePackage{newtxtext}  % Use Times Roman fonts
% FIXME: newtx 1.7 onwards has `amsthm` option which does the correct loading order:
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{newtxmath}  % Use Times Roman compatible math fonts
\RequirePackage[zerostyle=d,straightquotes]{newtxtt}  % Enhancement of typewriter fonts
\RequirePackage[T1]{fontenc}

% --- General style tweaks ---
\addtokomafont{disposition}{\linespread{1}\selectfont\rmfamily}  % Use single-spaced Roman font for section headings
\setkomafont{caption}{\footnotesize}  % Smaller font
\setkomafont{captionlabel}{\itshape}  % Italic caption label
\renewcommand*{\captionformat}{~}  % Space separator
\setcapindent{0pt}  % Don't indent captions
\pagestyle{plain}  % No headers

% --- ToC tweaks ---
\addto\captionsenglish{\renewcommand{\contentsname}{Table of Contents}}  % Rename ToC
\setuptoc{toc}{totoc}  % Add a ToC entry to the ToC
\PassOptionsToPackage{titletoc}{appendix}  % Prepend 'Appendix ' to each listing in the ToC

% --- Package Hooks: configure packages loaded by main.tex ---
\AfterPackage{biblatex}{\setcounter{biburlnumpenalty}{9000}}  % Make sure long URLs have line breaks
\AfterPackage{cleveref}{%
    \crefname{section}{Sec.}{Secs.}
    \Crefname{section}{Section}{Sections}
    \crefname{table}{Tab.}{Tabs.}
    \Crefname{table}{Table}{Tables}
}

% --- \printpreliminarypages command ---
% Smaller font size and centered chapter title for prelim pages
\newcommand{\prelimchapterstyle}{\addtokomafont{chapter}{\LARGE}\let\raggedchapter\centering}
\newcommand{\printpreliminarypages}{%
\iftoggle{proposal}{%
    \begin{singlespace}
        \begin{titlepage}\input{prelim_pages/title_proposal}\end{titlepage}
    \end{singlespace}
}{%
    \begin{singlespace}
        \begin{titlepage}\input{prelim_pages/title}\end{titlepage}
        \newpage
        \input{prelim_pages/univ_permission}
        \newpage
        \phantomsection  % anchor for hyperref in ToC
        \addcontentsline{toc}{chapter}{Approval Page}
        \input{prelim_pages/approval}
    \end{singlespace}
    {\prelimchapterstyle\input{prelim_pages/acknowledgments}}
}
{\prelimchapterstyle\input{prelim_pages/abstract}}
\begin{singlespace}
    \let\chapter\origchapter  % Use orig command to prevent line spacing changes
    \microtypesetup{protrusion=false}  % Disable protrusion
    \tableofcontents
    \listoftables
    \listoffigures
\end{singlespace}
}

% --- Review mode ---
\iftoggle{review}{%
% Add timestamp to the title page
\RequirePackage{datetime2}
\renewcommand{\SubmissionDate}{\texttt{\DTMnow}}
% Show line numbers
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

% Wrap \chapter in a single-space env to avoid unnecessary whitespace
\NewCommandCopy\origchapter\chapter
\makeatletter
\renewcommand{\chapter}{\@ifstar{\chapter@star}{\chapter@nostar}}
\newcommand{\chapter@nostar}{\@dblarg\@chapter@nostar}
\def\@chapter@nostar[#1]#2{\singlespace\origchapter[#1]{#2}\iftoggle{onehalfspacing}{\onehalfspacing}{\doublespacing}}
\newcommand{\chapter@star}[1]{\singlespace\origchapter*{#1}\iftoggle{onehalfspacing}{\onehalfspacing}{\doublespacing}}
\makeatother

% --- Abbreviations (extracted from CVPR template) ---
% Add a period to the end of an abbreviation unless there's one already, then \xspace.
\RequirePackage{xspace}
\makeatletter
\DeclareRobustCommand\onedot{\futurelet\@let@token\@onedot}
\newcommand\@onedot{\ifx\@let@token.\else.\null\fi\xspace}

\newcommand\eg{\emph{e.g}\onedot} \newcommand\Eg{\emph{E.g}\onedot}
\newcommand\ie{\emph{i.e}\onedot} \newcommand\Ie{\emph{I.e}\onedot}
\newcommand\cf{\emph{cf}\onedot} \newcommand\Cf{\emph{Cf}\onedot}
\newcommand\etc{\emph{etc}\onedot} \newcommand\vs{\emph{vs}\onedot}
\newcommand\wrt{w.r.t\onedot} \newcommand\dof{d.o.f\onedot}
\newcommand\iid{i.i.d\onedot} \newcommand\wolog{w.l.o.g\onedot}
\newcommand\etal{\emph{et al}\onedot}
\makeatother

% FIXME: biblatex is using the obsolete command \tt for some reason.
\let\tt\texttt

\endinput
