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
\ProvidesClass{manuscript}[2022/02/16 NGSE Manuscript]

% ----- Class Options -----
\RequirePackage{scrlfile}  % provides \AfterPackage{}
\RequirePackage{etoolbox}
\newtoggle{proposal}
\newtoggle{review}
\newtoggle{onehalfspacing}
% Proposal version
\DeclareOption{proposal}{\toggletrue{proposal}}
% Review version. Show line numbers and timestamp title page.
\DeclareOption{review}{\toggletrue{review}}
% Use 1.5 line spacing instead of double
\DeclareOption{onehalfspacing}{\toggletrue{onehalfspacing}}
% Customized biblatex styles
\DeclareOption{ieee}{\PassOptionsToPackage{bibstyle=ieee,citestyle=numeric-comp,sorting=nty,dashed=false}{biblatex}}
\DeclareOption{apa}{%
    \PassOptionsToPackage{style=apa}{biblatex}
    \AfterPackage{biblatex}{\setlength\bibitemsep{0.2\baselineskip}}  % add a bit of separation between bib items
}
% Use the `amsthm` package. Added as an option to ensure correct loading order.
\DeclareOption{amsthm}{\RequirePackage{amsmath,amsthm}}
% Pass unknown options to the scrbook class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax

% ----- \printpreliminarypages command -----
% Smaller font size and centered title for prelim chapters
\newcommand{\@prelimchapterstyle}{\addtokomafont{chapter}{\LARGE}\let\raggedchapter\centering}
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
    {\@prelimchapterstyle\input{prelim_pages/acknowledgments}}
}
{\@prelimchapterstyle\input{prelim_pages/abstract}}
\begin{singlespace}
    \microtypesetup{protrusion=false}  % Disable protrusion
    \tableofcontents
    \listoftables
    \listoffigures
\end{singlespace}
}

% ----- Abbreviations (extracted from CVPR template) -----
% Add a period to the end of an abbreviation unless there's one already, then \xspace.
\RequirePackage{xspace}
\DeclareRobustCommand\onedot{\futurelet\@let@token\@onedot}
\newcommand\@onedot{\ifx\@let@token.\else.\null\fi\xspace}

\newcommand\eg{\emph{e.g}\onedot} \newcommand\Eg{\emph{E.g}\onedot}
\newcommand\ie{\emph{i.e}\onedot} \newcommand\Ie{\emph{I.e}\onedot}
\newcommand\cf{\emph{cf}\onedot} \newcommand\Cf{\emph{Cf}\onedot}
\newcommand\etc{\emph{etc}\onedot} \newcommand\vs{\emph{vs}\onedot}
\newcommand\wrt{w.r.t\onedot} \newcommand\dof{d.o.f\onedot}
\newcommand\iid{i.i.d\onedot} \newcommand\wolog{w.l.o.g\onedot}
\newcommand\etal{\emph{et al}\onedot}

% ----- Start of internals -----

% listof=totoc: add List of Tables, Figures to ToC
% captions=tableheading: adjusts the spacing of captions placed above tables
\LoadClass[12pt,oneside,listof=totoc,captions=tableheading]{scrbook}

% --- Metadata ---
\input{manuscript-meta}
\PassOptionsToPackage{pdflang=en-PH,pdftitle={\Title},pdfauthor={\Student},pdfkeywords={\Keywords},pdfsubject={\Degree}}{hyperref}
% Infer manuscript type from the degree. FIXME: comparison should be case-insensitive
\RequirePackage{xstring}
\IfBeginWith{\Degree}{Master}{\newcommand\Type{Thesis}}{\newcommand\Type{Dissertation}}

% --- Page size and margins ---
\RequirePackage[margin=1in,footskip=0.6in,\iftoggle{proposal}{a4paper}{left=1.5in,letterpaper}]{geometry}

% --- Indents and line spacing ---
\setlength{\parindent}{0.5in}  % Half-inch indents
\RequirePackage{indentfirst}  % Indent the first paragraph of a section
\RequirePackage[\iftoggle{onehalfspacing}{onehalfspacing}{doublespacing}]{setspace}  % Set line spacing globally

% --- Hyphenation and typesetting ---
\RequirePackage[english]{babel}
\RequirePackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100]{microtype}
\UseMicrotypeSet[protrusion]{basicmath}  % disable protrusion for tt fonts

% --- Fonts (load after babel) ---
\RequirePackage{newtxtext,newtxmath}  % Use Times Roman fonts
\RequirePackage[zerostyle=d,straightquotes]{newtxtt}  % Enhancement of typewriter fonts
\RequirePackage[T1]{fontenc}

% --- General style tweaks ---
\pagestyle{plain}  % No headers
\addtokomafont{disposition}{\rmfamily}  % Use Roman font for section headings
\setkomafont{caption}{\footnotesize}  % Smaller caption font
\setkomafont{captionlabel}{\itshape}  % Italic caption label
\renewcommand*{\captionformat}{~}  % Space separator
\setcapindent{0pt}  % Don't indent captions

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

% --- Wrap \chapter in a singlespace env for consistency with prelim pages ---
\NewCommandCopy\chapter@orig\chapter
\newcommand{\@restorespacing}{\iftoggle{onehalfspacing}{\onehalfspacing}{\doublespacing}}
\renewcommand{\chapter}{\@ifstar{\chapter@star}{\@dblarg\chapter@nostar}}
\def\chapter@nostar[#1]#2{\singlespace\chapter@orig[#1]{#2}\@restorespacing}
\newcommand{\chapter@star}[1]{\singlespace\chapter@orig*{#1}\@restorespacing}
% Revert to orig command inside singlespace env to prevent unwanted line spacing changes
\AtBeginEnvironment{singlespace}{\let\chapter\chapter@orig}

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
\renewcommand\makeLineNumberLeft{%
    \linenumberfont
    \llap{\hss\LineNumber\hskip\linenumbersep}  % left margin
    \hskip\columnwidth\hskip\linenumbersep
    \rlap{\hb@xt@\linenumberwidth{\hss\LineNumber}\hss}  % right margin
}
\leftlinenumbers  % Re-issue [left] option
\linenumbers
}{}

% FIXME: biblatex is using the obsolete command \tt for some reason.
\let\tt\texttt

\endinput
