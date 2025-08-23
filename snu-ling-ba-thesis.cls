%%
%% This is file `snu-ling-ba-thesis.cls'.
%%
%% ----------------------------------------------------------------------
%% The snu-ling-ba-thesis class --- A class for SNU Linguistics BA theses
%% Maintained by Junyoung Park
%% E-mail: bloomwayz@snu.ac.kr
%% Released under the MIT License.
%% ----------------------------------------------------------------------
%%
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\RequirePackage{expl3}
\ProvidesExplClass
  {snu-ling-ba-thesis}
  {2025/08/24}
  {0.1}
  {A class for SNU Linguistics BA theses}


%%%%%%%%%%%%%%%%%%%%%%%%%
% Options for the class %
%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareKeys {
  en .code = { \bool_set_true:N \l_snu_ling_ba_thesis_en_bool },
  ko .code = { \bool_set_false:N \l_snu_ling_ba_thesis_en_bool },
}
\SetKeys { ko }
\ProcessKeyOptions


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% XeLaTeX or LuaLaTeX required %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{iftex}
\ifXeTeX\else\ifLuaTeX\else
  \ClassError {snu-ling-ba-thesis}
    { This~class~only~supports~XeLaTeX~and~LuaLaTeX. }
    { Please~use~either~XeLaTeX~or~LuaLaTeX. }
\fi\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language-specific settings %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tl_const:Nn \l_snu_ling_ba_thesis_abstractname_ko { 논문~초록 }
\tl_const:Nn \l_snu_ling_ba_thesis_contentsname_ko { 목차 }
\tl_const:Nn \l_snu_ling_ba_thesis_appendixname_ko { 부록 }
\tl_const:Nn \l_snu_ling_ba_thesis_abstractname_en { Abstract }
\tl_const:Nn \l_snu_ling_ba_thesis_contentsname_en { Contents }
\tl_const:Nn \l_snu_ling_ba_thesis_appendixname_en { Appendix }

\bool_if:NTF \l_snu_ling_ba_thesis_en_bool
  { % English main
    \LoadClass[13pt, a4paper]{article}
    \RequirePackage{kotex}

    \RequirePackage[doublespacing]{setspace}
    \RequirePackage{caption}
    % If the setspace is used in conjuction with the caption package, the caption
    % will be typeset with single spacing as default.
    \captionsetup[table]{font=onehalfspacing}
    \captionsetup[figure]{font=onehalfspacing}

    \let\abstractname\l_snu_ling_ba_thesis_abstractname_en
    \let\contentsname\l_snu_ling_ba_thesis_contentsname_en
    \let\appendixname\l_snu_ling_ba_thesis_appendixname_en
    \AddToHook {begindocument/before} {
      \let\oldprintbibliography\printbibliography
      \renewcommand{\printbibliography}{
        \oldprintbibliography[heading=none]
      }
    }
  }
  { % Korean main
    \LoadClass[12pt, a4paper]{article}
    \RequirePackage[hangul]{kotex}

    \RequirePackage[doublespacing]{setspace}
    \RequirePackage{caption}
    \captionsetup[table]{name=표}
    \captionsetup[figure]{name=그림}

    \let\abstractname\l_snu_ling_ba_thesis_abstractname_ko
    \let\contentsname\l_snu_ling_ba_thesis_contentsname_ko
    \let\appendixname\l_snu_ling_ba_thesis_appendixname_ko
    \AddToHook {begindocument/before} {
      \let\oldprintbibliography\printbibliography
      \renewcommand{\printbibliography}{
        \oldprintbibliography[heading=none]
      }
    }
  }


%%%%%%%%%%%%%%%%%%%%%%%%
% Package dependencies %
%%%%%%%%%%%%%%%%%%%%%%%%
% Subfigures
\RequirePackage{subcaption}

% Images
\RequirePackage{graphicx}

% Tables
\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}

% Math
\RequirePackage{amssymb,amsmath,mathtools} % Before unicode-math
% \RequirePackage[math-style=TeX,bold-style=TeX]{unicode-math}

\RequirePackage{xcolor}

% Chapter style
\RequirePackage{titlesec}

% First-line indentation
\RequirePackage{indentfirst}

% Bibliography
\RequirePackage[style=apa]{biblatex}
\RequirePackage{xstring}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page layout configuration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addtolength{\hoffset}{-1in}
\addtolength{\voffset}{-1in}
\setlength{\topmargin}{20mm}
\setlength{\headheight}{0mm}
\setlength{\headsep}{15mm}
\setlength{\marginparwidth}{0mm}
\setlength{\marginparsep}{0mm}
\setlength{\oddsidemargin}{30mm}
\setlength{\textwidth}{150mm}
\setlength{\textheight}{232mm}
\setlength{\footskip}{15mm}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chapter / section style configuration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\titleformat{\section}
  { \normalfont\fontsize{12pt}{13pt}\selectfont\bfseries }
  { \thesection. }
  { .5em }
  { }

\titleformat{\subsection}
  { \normalfont\fontsize{12pt}{13pt}\selectfont\bfseries }
  { \thesubsection. }
  { .5em }
  { }

\titleformat{\subsubsection}
  { \normalfont\fontsize{12pt}{13pt}\selectfont\bfseries }
  { \thesubsubsection. }
  { .5em }
  { }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paragraph style configuration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\parindent}{4mm}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document metadata fields %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand \subtitle { m }
  { \newcommand*\@subtitle{#1} }

\NewDocumentCommand \affil { m }
  { \newcommand*\@affil{#1} }

\NewDocumentCommand \advisor { m }
  { \newcommand*\@advisor{#1} }

\newcommand\subtitleoption{
  \StrLen{\@subtitle}[\subtitle_len]
  \int_compare:nTF { \subtitle_len < 2 }
    { \mbox{} }
    { :~\@subtitle }
}

\newcommand\authorspaced{
  \StrLen{\@author}[\author_name_len]
  \int_compare:nTF { \author_name_len > 3 }
    { \@author }
    {
      \tl_map_inline:Nn { \@author } { ##1~ }
    }
}

% https://github.com/latex3/hyperref/issues/242#issuecomment-1149845979
\AddToHook {begindocument/before} {
  \hypersetup{
    colorlinks,
    linkcolor={black},
    citecolor={red!73!black},
    urlcolor={blue!60!black},

    pdflang = { \bool_if:NTF \l_snu_ling_ba_thesis_en_bool { en } { ko } },
    pdfsubject = {언어학학사~학위논문}
  }
}

% Redefine \maketitle
\AtBeginDocument {
  % hyperref package redefines \@maketitle
  \def\HyOrg@maketitle{
    \newpage

    % cover
    \thispagestyle{empty}
    \begin{center}
      \fontsize{12pt}{13pt}\selectfont\mdseries
      언어학학사~학위논문 \\
      \mbox{} \\
      \fontsize{18pt}{21pt}\selectfont\bfseries
      \@title \\
      \fontsize{14pt}{16pt}\selectfont\bfseries
      \subtitleoption \\
      \vfill
      \vfill
      \fontsize{12pt}{13pt}\selectfont\mdseries
      \@date \\
      \vfill
      \fontsize{14pt}{16pt}\selectfont\mdseries
      지도교수:~\@advisor \\
      \mbox{} \\
      \fontsize{14pt}{16pt}\selectfont\mdseries
      \@affil \\
      \mbox{} \\
      \authorspaced \\
    \end{center}
    \newpage
  }
}

% abstract
\RenewDocumentEnvironment { abstract } { o }
  {
    \begin{center}
      \fontsize{14pt}{16pt}\selectfont\bfseries
      \abstractname \\
      \mbox{} \\
    \end{center}
  }
  {
    \newpage
  }

% contents
\renewcommand{\tableofcontents}{
  \begin{center}
    \fontsize{14pt}{16pt}\selectfont\bfseries
    \contentsname \\
    \mbox{} \\
  \end{center}
  \par\nobreak\@afterheading
  \@starttoc{toc}
  \newpage
}

\newcounter{apxnum}

\renewcommand{\appendix}{
  \setcounter{apxnum}{0}
}

\newcommand{\apxitem}[2][]{
  \refstepcounter{apxnum}
  \subsection*{〈\appendixname\ \arabic{apxnum}〉 #2}
  \addcontentsline{toc}{subsection}{〈\appendixname\ \arabic{apxnum}〉 #2}
  \if\relax\detokenize{#1}\relax\else\label{#1}\fi
}
