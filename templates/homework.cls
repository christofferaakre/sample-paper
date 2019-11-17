\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2019/10/14 Homework class]
\LoadClass[12pt]{article}
\RequirePackage[utf8]{inputenc}
\RequirePackage{chngcntr}

\RequirePackage[backend=biber,
            style=apa,
            citestyle=authoryear
            ]
            {biblatex}
\RequirePackage{graphicx}
\RequirePackage{csquotes}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage[makeroom]{cancel}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{float}
\RequirePackage{setspace}
\RequirePackage{enumerate}
\makeatletter
\let\@xfloat=\latex@xfloat % revert setspace patch of floating environments
\makeatother
\RequirePackage{hyperref}
\RequirePackage[nameinlink]{cleveref}
\RequirePackage[labelfont=bf]{caption}
\RequirePackage[separate-uncertainty = true,multi-part-units=single]{siunitx}
\RequirePackage{listings}
\RequirePackage{letltxmacro}
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{bm}
\RequirePackage[toc, page]{appendix}
\RequirePackage{chemfig}
\pgfplotsset{compat=1.15}
\RequirePackage{gensymb}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}

\makeatletter
\renewcommand{\@evenfoot}{\hfil page \thepage{} of \pageref*{LastPage}\hfil}
\renewcommand{\@oddfoot}{\@evenfoot}
\makeatother

\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[C]{\thepage\ of \pageref{LastPage}}
\fancypagestyle{plain}{%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyhf{}%
  \fancyfoot[C]{\thepage\ of \pageref{LastPage}}}


% Configuring hyperlinks
\hypersetup{
    colorlinks=true,
    linkcolor=black,
    urlcolor=blue,
    citecolor=black
}
\DeclareLanguageMapping{english}{english-apa}
\urlstyle{same}
% Configuring floor and ceil functions
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
% Layout and style
\makeatletter
\g@addto@macro\@floatboxreset{\centering}
\makeatother
\doublespacing
\captionsetup{labelfont=bf}


\newenvironment{boldenumerate}
{
\begin{enumerate}\renewcommand\labelenumi{\textbf\theenumi}}
{\end{enumerate}
}

\floatplacement{figure}{H}

\let\oldhat\hat
\renewcommand{\hat}[1]{\oldhat{\mathbf{#1}}}

\let\oldvec\vec

\renewcommand{\vec}[1]{{\bm{\oldvec{#1}}}}

\floatplacement{figure}{H}
\floatplacement{table}{H}

% Setting up graphics
\graphicspath{ {./diagrams/} }
\LetLtxMacro{\OldIncludegraphics}{\includegraphics}
\renewcommand{\includegraphics}[2][]{\OldIncludegraphics[width=\textwidth,height=\textheight,keepaspectratio #1]{#2}}


% Commands
\newcommand{\reference}[2]{\textbf{\hyperref[#1]{#2}}}
\newcommand{\figref}[1]{\textbf{\autoref{#1}}}
\newcommand{\tableref}[1]{\textbf{\autoref{#1}}}
\newcommand{\sectionref}[1]{\textbf{\Cref{#1}}}
\newcommand{\boldcaption}[1]{\textbf{\caption{#1}}}
\newcommand{\Mod}[0]{\textnormal{mod}}
\newcommand{\avg}[0]{\textnormal{avg}}
    \newcommand{\sgn}[0]{\textnormal{sgn}}
\newcommand{\bp}[1]{\textbf{\underline{#1}}}
    \newcommand{\sectionparagraph}[1]{\paragraph{\underline{#1.}}}
\newcommand{\Var}[0]{\textnormal{Var}}

\newcommand{\Quote}[1]{\enquote*{#1}}

\newcommand{\source}[1]{\caption*{Source: {#1}} }

\let\oldSI\SI
\renewcommand{\SI}[2]{\text{\oldSI{#1}{#2}}}

% Bibliography setup
\addbibresource{references.bib}
% Fix cross references
\ExecuteBibliographyOptions{maxcitenames=1}
\DeclareFieldFormat{citehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{#1}}

\DeclareFieldFormat{textcitehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{%
    #1%
    \ifbool{cbx:parens}
      {\bibcloseparen\global\boolfalse{cbx:parens}}
      {}}}

\savebibmacro{cite}
\savebibmacro{textcite}

\renewbibmacro*{cite}{%
  \printtext[citehyperref]{%
    \restorebibmacro{cite}%
    \usebibmacro{cite}}}

\renewbibmacro*{textcite}{%
  \ifboolexpr{
    ( not test {\iffieldundef{prenote}} and
      test {\ifnumequal{\value{citecount}}{1}} )
    or
    ( not test {\iffieldundef{postnote}} and
      test {\ifnumequal{\value{citecount}}{\value{citetotal}}} )
  }
    {\DeclareFieldAlias{textcitehyperref}{noformat}}
    {}%
  \printtext[textcitehyperref]{%
    \restorebibmacro{textcite}%
    \usebibmacro{textcite}}}

\setcounter{part}{1}
\renewcommand{\part}{\textbf{\LARGE{Part \thepart}} \addtocounter{part}{1}}

\newcommand{\exercise}{\addtocounter{section}{1} \section*{Exercise \thesection}}

\usepackage{parskip}
\setcounter{subsection}{1}

\newbool{long}

\newcommand{\exercisepart}{\ifnum\the\value{subsection}>1 \hfill\\ \fi
 \textbf{(\alph{subsection}}) \addtocounter{subsection}{1}}
\setcounter{subsubsection}{1}

\newenvironment{subexercises}{
    \begin{enumerate}[\hspace{0.7cm} i]\renewcommand{\labelenumi}{(\theenumi)}
}{
    \end{enumerate}
}