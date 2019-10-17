% pdg.cls
% Format reviews for PDG
% 2018-Mar-08  Jeffrey Anderson JDAnderson (at) lbl.gov

\ProvidesClass{pdg}[2019/03/01 version 1.20 PDG review format]
\NeedsTeXFormat{LaTeX2e}
% This class extends the extbook class


\RequirePackage{xifthen} % for conditional statements

\RequirePackage{xcite}
\RequirePackage{xr-hyper}


% Some internal booleans to control flow
\newif\ifrppbook
\newif\ifrppweb
\newif\ifrppbooklet

\newif\ifischapter
\newif\ifismergedreview

\newcommand{\baseclass}{extbook}

% Allow booleans to be set as options passed to the pdg class
\@ifclasswith{pdg}{rppbook}{\rppbooktrue}{\rppbookfalse}
\@ifclasswith{pdg}{rppweb}{\rppwebtrue}{\rppwebfalse}
\@ifclasswith{pdg}{rppbooklet}{\rppbooklettrue}{\rppbookletfalse}
\@ifclasswith{pdg}{toplevel}{\ismergedreviewtrue}{}

% \isbook \isbooklet and \isweb are booleans that can be passed on the command line to set or override class options given in the review source files.
\ifdefined\isbook
\rppbooktrue
\rppwebfalse
\rppbookletfalse
\fi

\ifdefined\isweb
\rppwebtrue
\rppbookfalse
\rppbookletfalse
\fi

\ifdefined\isbooklet
\rppbooklettrue
\rppwebfalse
\rppbookfalse
\def\nohyperref
\fi

% If neither book nor web is specified, assume draft
\ifthenelse{\isundefined\isbook \AND \isundefined\isweb \AND \isundefined\isbooklet}{\def\isdraft{1}}{}

\ifdefined\isdraft
\rppwebtrue
\rppbookfalse
\rppbookletfalse
\fi


% Set default options to pass to base class
\DeclareOption{rppbook} {%
  \PassOptionsToClass{8pt,twoside,twocolumn}{\baseclass}

}

\DeclareOption{rppweb} {%
  \PassOptionsToClass{11pt,onecolumn}{\baseclass}
}

% We actually set the booklet font in the tex files.  
% 8pt is the smallest we can pass to book as an option
\DeclareOption{rppbooklet} {%
  \PassOptionsToClass{8pt,twoside,onecolumn}{\baseclass}
}

%\DeclareOption{draft} {}

% Pass through any other options
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{\baseclass}}


\ifrppbook
\ExecuteOptions{rppbook} % rppbook is default
\fi

\ifrppweb
\ExecuteOptions{rppweb} 
\fi

\ifrppbooklet
\ExecuteOptions{rppbooklet}
\fi

\ProcessOptions\relax

% Load base class
\LoadClass{\baseclass}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Many external packages and definitions.  These will be replaced with canonical definitions in the final version.


\newcommand\bumpupfigurenumber{\stepcounter{figure}}
\newcommand\bumpuptablenumber{\stepcounter{table}}
\newcommand\bumpupsubsubsectionnumber{\stepcounter{subsubsection}}
\newcommand\bumpupsubsectionnumber{\stepcounter{subsection}}
\newcommand\bumpupsectionnumber{\stepcounter{section}}
\newcommand\bumpupequationnumber{\stepcounter{equation}}

% This allows us to test whether a counter has been set
\newcommand*\ifcounter[1]{%
  \ifcsname c@#1\endcsname
    \ifnum\value{#1}=0
    \expandafter\@secondoftwo
    \else
    \expandafter\@firstoftwo
    \fi
  \else
    \expandafter\@secondoftwo
  \fi
}

\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[nodayofweek,level,12hr]{datetime}
\RequirePackage{color}
\RequirePackage{float} % to control figure placement
\RequirePackage[utf8]{inputenc} 
\RequirePackage{xspace} 
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{rotating}

%%% Decrease line spacing in itemize and enumerate lists
\RequirePackage{paralist}
  \let\itemize\compactitem
  \let\enditemize\endcompactitem
  \let\enumerate\compactenum
  \let\endenumerate\endcompactenum
  \let\description\compactdesc
  \let\enddescription\endcompactdesc
  \pltopsep=\medskipamount
  \plitemsep=1pt
  \plparsep=1pt


\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{hhline}
\RequirePackage{isomath}

\RequirePackage{graphicx}  % to include figures (can also use other packages)
% Set default graphics width to be one column of a two-column page.
\setkeys{Gin}{width=0.49\textwidth}
%\RequirePackage{tabularx}

% Greater control over table caption formatting
\RequirePackage{caption}


%%%%%   Define a number of custom commands and environments %%%%%
\newcommand{\pdgfigure}[5]{
\ifthenelse{\isempty{#4}}{%
  \begin{figure}[!ht]}{%
  \begin{figure}[#4]}
    \centering
%% Still experimenting with figure scaling
\ifthenelse{\isempty{#5}}{%
    \includegraphics[width=.85\linewidth]{figures/#1}}{%
  \includegraphics[#5]{figures/#1}}
%    \includegraphics[#5]{figures/#1}
    \caption{#2}\label{#3}
  \end{figure}
}

\newcommand{\pdgwidefigure}[5]{
\ifthenelse{\isempty{#4}}{%
  \begin{figure*}[!ht]}{%
  \begin{figure*}[#4]}
    \centering
\ifthenelse{\isempty{#5}}{%
    \includegraphics[width=\textwidth]{figures/#1}}{%
  \includegraphics[#5]{figures/#1}}
    \caption{#2}\label{#3}
  \end{figure*}
}

\newcommand{\pdgdoublefigure}[6]{
\ifthenelse{\isempty{#5}}{%
  \begin{figure}[!ht]}{%
  \begin{figure}[#5]}
    \centering
    \includegraphics[#6]{figures/#1}
    \includegraphics[#6]{figures/#2}
    \caption{#3}\label{#4}
  \end{figure}
}

\newcommand{\pdgdoublefigurex}[7]{
\ifthenelse{\isempty{#5}}{%
  \begin{figure}[!ht]}{%
  \begin{figure}[#5]}
    \centering
    \includegraphics[#6]{figures/#1}
    \includegraphics[#7]{figures/#2}
    \caption{#3}\label{#4}
  \end{figure}
}


\RequirePackage{bigstrut}
    \setlength\bigstrutjot{1pt}
\newlength\mylena
\newlength\mylenb
\newcommand\mystrut[1][2]{%
    \setlength\mylena{#1\ht\@arstrutbox}%
    \setlength\mylenb{#1\dp\@arstrutbox}%
    \rule[\mylenb]{0pt}{\mylena}}

%\newcommand\tableline{\noalign{\smallskip}\hline\noalign{\smallskip}\bigstrut[t]\bigstrut[b]}
\newcommand\tableline{\noalign{\smallskip}\hline\noalign{\smallskip}}
\newcommand\Tablerule{\noalign{\smallskip}\hline\noalign{\smallskip}}
\newcommand\tabledoubleline{\noalign{\smallskip}\hline\hline\noalign{\smallskip}}

\newcommand{\pdgtableheader}[1]{%
#1\\
\hline
%\tableline
%\noalign{\smallskip}
%\mystrut[.5]
%\noalign{\smallskip}#1\\
%\noalign{\smallskip}\hline\noalign{\smallskip}
}

\newcolumntype{P}[1]{>{\raggedright\arraybackslash}p{#1}}
\RequirePackage{varwidth}

\RequirePackage{footmisc}
%\RequirePackage{adjustbox}
\RequirePackage{relsize}

\newenvironment{pdgtable}[4]{% #1
\captionsetup{width=.75\linewidth,labelfont=bf}
\ifthenelse{\isempty{#4}}{%
  \begin{table}[!ht]}{%
  \begin{table}[#4]}
\centering
\setlength{\parindent}{0pt}
\begin{minipage}{\columnwidth}% so footnote will appear
\renewcommand*{\thempfootnote}{\fnsymbol{mpfootnote}}
\renewcommand*\footnoterule{}
    \caption{#2}
    \label{#3}
    \centering
    \begin{tabular}{@{}#1@{}}
        \hline\hline
}{%
  \hline\hline
    \end{tabular}
    \end{minipage}
    \end{table}
}

\newenvironment{pdgwidetable}[4]{%
\captionsetup{width=1\textwidth,labelfont=bf}
\ifthenelse{\isempty{#4}}{%
  \begin{table*}[!ht]}{%
  \begin{table*}[#4]}
\begin{minipage}{\textwidth} % so footnote will appear
\renewcommand*{\thempfootnote}{\fnsymbol{mpfootnote}}
\renewcommand*\footnoterule{}
    \caption{#2}
    \label{#3}
    \centering
    \begin{tabular}{@{}#1@{}}
        \hline\hline
}{%
  \hline\hline
    \end{tabular}
    \end{minipage}
    \end{table*}
}

\newenvironment{pdgverywidetable}[4]{% #1
\captionsetup{width=1\linewidth,labelfont=bf}
\ifthenelse{\isempty{#4}}{%
  \begin{table*}[!ht]}{%
  \begin{table*}[#4]}
\relscale{.95}
\centering
\setlength{\parindent}{0pt}
\begin{minipage}{\linewidth}% so footnote will appear
\renewcommand*{\thempfootnote}{\fnsymbol{mpfootnote}}
\renewcommand*\footnoterule{}
    \caption{#2}
    \label{#3}
%    \begin{adjustbox}{width=\linewidth}
    \centering
    \begin{tabular}{@{}#1@{}}
        \hline\hline
}{%
  \hline\hline
    \end{tabular}
%    \end{adjustbox}
    \end{minipage}
    \end{table*}
}


\newenvironment{pdgscaletable}[5]{% #1
\captionsetup{width=.75\linewidth,labelfont=bf}
\ifthenelse{\isempty{#4}}{%
  \begin{table}[!ht]}{%
  \begin{table}[#4]}
\ifthenelse{\isempty{#5}}{\relscale{.95}}{\relscale{#5}}
\centering
\setlength{\parindent}{0pt}
\begin{minipage}{\linewidth}% so footnote will appear
\renewcommand*{\thempfootnote}{\fnsymbol{mpfootnote}}
\renewcommand*\footnoterule{}
    \caption{#2}
    \label{#3}
%    \begin{adjustbox}{width=\linewidth}
    \centering
    \begin{tabular}{@{}#1@{}}
        \hline\hline
}{%
  \hline\hline
    \end{tabular}
%    \end{adjustbox}
    \end{minipage}
    \end{table}
}

\newenvironment{pdgscaletable*}[5]{% #1
\captionsetup{width=.75\linewidth,labelfont=bf}
\ifthenelse{\isempty{#4}}{%
  \begin{table*}[!ht]}{%
  \begin{table*}[#4]}
\ifthenelse{\isempty{#5}}{\relscale{.95}}{\relscale{#5}}
\centering
\setlength{\parindent}{0pt}
\begin{minipage}{\linewidth}% so footnote will appear
\renewcommand*{\thempfootnote}{\fnsymbol{mpfootnote}}
\renewcommand*\footnoterule{}
    \caption{#2}
    \label{#3}
%    \begin{adjustbox}{width=\linewidth}
    \centering
    \begin{tabular}{@{}#1@{}}
        \hline\hline
}{%
  \hline\hline
    \end{tabular}
%    \end{adjustbox}
    \end{minipage}
    \end{table*}
}

\newenvironment{pdgsidewaystable}[4]{% #1
\captionsetup{width=.75\linewidth,labelfont=bf}
\ifthenelse{\isempty{#4}}{%
  \begin{sidewaystable*}[!ht]}{%
  \begin{sidewaystable*}[#4]}
\relscale{.95}
\centering
\setlength{\parindent}{0pt}
\begin{minipage}{\linewidth}% so footnote will appear
\renewcommand*{\thempfootnote}{\fnsymbol{mpfootnote}}
\renewcommand*\footnoterule{}
    \caption{#2}
    \label{#3}
%    \begin{adjustbox}{width=\linewidth}
    \centering
    \begin{tabular}{@{}#1@{}}
        \hline\hline
}{%
  \hline\hline
    \end{tabular}
%    \end{adjustbox}
    \end{minipage}
    \end{sidewaystable*}
}


%
\RequirePackage{import}

%%% Bibliography
%\RequirePackage{setspace}
\RequirePackage[globalcitecopy,labelstoglobalaux]{bibunits}
\RequirePackage{cite,mciteplus}
\defaultbibliographystyle{pdg}

% Print ``References'' instead of ``Bibliography
% Make review bibliographies start immediately after text, 
% not on a new page


\newlength{\bibitemsep}\setlength{\bibitemsep}{0pt plus 0.3ex}
\newlength{\bibparskip}\setlength{\bibparskip}{0pt}
\let\stdthebibliography\thebibliography
\renewcommand{\thebibliography}{%
  \renewcommand{\bibname}{References}
  \setlength{\parskip}{\bibparskip}%
  \setlength{\itemsep}{-.3ex}%
  \let\chapter\subsection
  \stdthebibliography%
}

\let\oldthebibliography=\thebibliography
\let\endoldthebibliography=\endthebibliography
\renewenvironment{thebibliography}[1]{%
   \begin{oldthebibliography}{#1}%
     \setlength{\itemsep}{-.3ex}%
}%
{%
   \end{oldthebibliography}%
}

\renewcommand{\@bibunitname}{\jobname.\the\@bibunitauxcnt}

%%% Configure line numbers and margin tags for draft mode
\RequirePackage[left]{lineno}
\ifdefined\isdraft
\linenumbers
\RequirePackage[inline]{showlabels}
% The following should cause labels to be rendered in red.
% Unfortunately, when the labels are inline, this causes all 
% text to be red.
\renewcommand{\showlabelfont}{\tiny}
\showlabels{cite}
\showlabels{bibitem}
\fi

\let\oldputbib\putbib
\renewcommand{\putbib}[1][]{
\renewcommand{\markboth}[2]{}
\oldputbib[#1]
}

%%% Don't change the running header inside the bibliography
\newcommand\inputbib[1]{
\renewcommand{\markboth}[2]{}
\input{#1}
}

%%% Special bibliography handling for toplevel reviews
\def\putmergedbib{\@ifnextchar[{\@putmergedbib}{\@putmergedbib[\bu@bibdata]}}
\def\@putmergedbib[#1]{%
  \@startbibunitorrelax
  \if@filesw
    \immediate\write\@bibunitaux{\string\bibdata{#1}}%
  \fi
  \@input@{\@bibunitname.bbl}%
}
\ifismergedreview \def\@putbib[#1]{\relax} \fi


% Packages to control style of titles and page headers
\RequirePackage{titling}
\RequirePackage{fancyhdr}
\RequirePackage[titles]{tocloft}
%\RequirePackage{minitoc}
%\nomtcrule
%\renewcommand{\mtctitle}{}
\let\@@l@chapter\l@chapter
\def\l@chapter#1{\@@l@chapter{}}
\cftpagenumbersoff{chapter}

% Prevent clearpage before TOC.  Insert blank line after TOC
\renewcommand\tableofcontents{%
  \@starttoc{toc}
  \hfill\par
}
\addtolength{\cftsecnumwidth}{10pt}
\addtolength{\cftchapnumwidth}{10pt}
\renewcommand{\@cftmaketoctitle}{}


%%% Customize title formats
\RequirePackage[compact]{titlesec}

%%%% Define subsubsubsection between subsubsection and paragraph
\titleclass{\subsubsubsection}{straight}[\subsection]

\newcounter{subsubsubsection}[subsubsection]
%\renewcommand\thesubsubsubsection{\thesubsubsection.\roman{subsubsubsection}}
\renewcommand\thesubsubsubsection{\roman{subsubsubsection}.}
%\renewcommand\theparagraph{\thesubsubsubsection.\arabic{paragraph}} % optional; useful if paragraphs are to be numbered

\titleformat{\subsubsubsection}
  {\normalsize\mdseries}{\thesubsubsubsection}{.5em}{\itshape}
\titlespacing*{\subsubsubsection}
{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}


\renewcommand\paragraph{\@startsection{paragraph}{5}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{6}{\parindent}%
  {3.25ex \@plus1ex \@minus .2ex}%
  {-1em}%
  {\normalfont\normalsize\bfseries}}
\def\toclevel@subsubsubsection{4}
\def\toclevel@paragraph{5}
\def\toclevel@paragraph{6}
\def\l@subsubsubsection{\@dottedtocline{4}{7em}{4em}}
\def\l@paragraph{\@dottedtocline{5}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{6}{14em}{6em}}

\setcounter{secnumdepth}{4}
%%%%


%% Format Chapter titles
\ifrppbooklet
\titlespacing{\chapter}{0pt}{-15pt}{5pt}
\titleformat{\chapter}[block]
{\centering\bfseries\Large}
{\thechapter.}
  {1ex}
%  {\vspace{1ex}\filcenter}
  {\vspace{0ex}}
  [\vspace{0ex}]
\else
\titlespacing{\chapter}{0pt}{-15pt}{5pt}
\titleformat{\chapter}[block]
{\centering\bfseries\Large}
{\thechapter.}
  {1ex}
%  {\vspace{1ex}\filcenter}
  {\vspace{1ex}}
  [\vspace{1ex}]
\fi
%%

\titleformat{\section}[block]{\large\bfseries}{\thesection}{.5em}{}
%\titleformat*{\subsection}{\normalsize\bfseries}
\titleformat{\subsection}[block]{\normalsize\bfseries}{\thesubsection}{.5em}{\itshape}
\titleformat{\subsubsection}[block]{\normalsize\mdseries}{\thesubsubsection}{.5em}{\itshape}
\titlespacing{\section}{0pt}{5pt}{0pt}
\titlespacing{\subsection}{0pt}{5pt}{0pt}
\titlespacing{\subsubsection}{0pt}{5pt}{0pt}


%%% New macros for setting titles and authors
\newcommand{\chapterauthor}[1]{%
  {\parindent0pt\vspace*{-25pt}%
  \linespread{1.1}\scshape#1%
  \par\nobreak\vspace*{35pt}}
  \@afterheading%
}

%%% Don't label sections and subsections as chapter 0 if using \chapter*
\let\stdthesubsubsubsection\thesubsubsubsection
\renewcommand{\thesubsubsubsection}{%
  \ifischapter%
  \stdthesubsubsubsection\else\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.\arabic{subsubsubsection}\fi%
}

\let\stdthesubsubsection\thesubsubsection
\renewcommand{\thesubsubsection}{%
  \ifischapter%
  \stdthesubsubsection\else\arabic{section}.\arabic{subsection}.\arabic{subsubsection}\fi%
}
\let\stdthesubsection\thesubsection
\renewcommand{\thesubsection}{%
  \ifischapter%
  \stdthesubsection\else\arabic{section}.\arabic{subsection}\fi%
}
\let\stdthesection\thesection
\renewcommand{\thesection}{%
  \ifischapter%
  \stdthesection\else\arabic{section}\fi%
}

\newcommand\reviewtitle[1]{\renewcommand\@reviewtitle{#1}}
\newcommand\@reviewtitle{}

\newcommand\sectiontitle[1]{\renewcommand\@sectiontitle{#1}}
\newcommand\@sectiontitle{}

\newcommand\subsectiontitle[1]{
  \setcounter{secnumdepth}{5}
  \renewcommand\@subsectiontitle{#1}}
\newcommand\@subsectiontitle{}

\newcommand\reviewlabel[1]{\renewcommand\@reviewlabel{#1}}
\newcommand\@reviewlabel{}

\newcommand\sectionlabel[1]{\renewcommand\@sectionlabel{#1}}
\newcommand\@sectionlabel{}



\newcommand\pdgtitle[1][]{%
\ifthenelse{\equal{\@subsectiontitle}{}}
{
  \ifthenelse{\equal{\@sectiontitle}{}}
      {
	\ifthenelse{\equal{#1}{}}
	{ %\bibliographyunit[\chapter]
	  \ifischapter \chapter{\@reviewtitle}% 
	  \else{\chapter*{\@reviewtitle}\markboth{\@reviewtitle}{\@reviewtitle}}
	  \fi%
	}
	{ %\bibliographyunit[\chapter]
	  \ifischapter \chapter{#1}%
	  \else{\chapter*{#1}\markboth{#1}{#1}}
	  \fi%
	}
      }
      {
	\ifthenelse{\equal{#1}{}}
		   {\section{\@sectiontitle}}
		   {\section{#1}}
      }
}
{
  \ifthenelse{\equal{#1}{}}
  {\subsection{\@subsectiontitle}}
  {\subsection{#1}}
}
\ifthenelse{\equal{\@reviewlabel}{}}
{}{\label{\@reviewlabel}}
\ifthenelse{\equal{\@sectionlabel}{}}
{}{\label{\@sectionlabel}}
}

\newcommand\reviewauthor[1]{\renewcommand\@reviewauthor{#1}}
\newcommand\@reviewauthor{}

\newcommand{\showreviewtitle}{%
    {\@reviewtitle}
    \@afterheading%
}

\newcommand{\written}[1]{%
  {\parindent0pt%\vspace*{-25pt}%
  \linespread{1.1}{Written #1 by \@reviewauthor.}%
  \par\nobreak\vspace*{5pt}}
  \@afterheading%
}

\newcommand{\revised}[1]{%
  {\parindent0pt%\vspace*{-25pt}%
  \linespread{1.1}{Revised #1 by \@reviewauthor.}%
  \par\nobreak\vspace*{5pt}}
  \@afterheading%
}

\newcommand{\customauthor}[1]{%
  {\parindent0pt%\vspace*{-25pt}%
  \linespread{1.1}#1%
  \par\nobreak\vspace*{5pt}}
  \@afterheading%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom pagestyles


\newcommand\rppfooter[1]{%
  \ifthenelse{\isempty{#1}}{%
    \fancyfoot{}
    \fancypagestyle{plain}{\fancyfoot{}}
}{
    \ifrppbook \geometry{includefoot} \fi
    \fancyfoot{}
    \fancyfoot[C]{\scriptsize #1}
    \fancypagestyle{plain}{\fancyfoot[C]{\scriptsize #1}}
}}


\fancypagestyle{rppbook}{%
\fancyhf{} % clear the fields
\renewcommand{\@chapapp}{}
\fancyhead[LE]{\thepage\xspace\xspace\xspace\bf\itshape\nouppercase{\leftmark}}
\fancyhead[RO]{{\bf\itshape\nouppercase{\leftmark}}\xspace\xspace\xspace\thepage}
\fancyhead[RE,LO]{}
}

\fancypagestyle{rppweb}{%
\fancyhf{}
\renewcommand{\@chapapp}{}
\setlength{\headheight}{14pt}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[L]{\thepage}
\fancyhead[C]{\bf\itshape\nouppercase{\leftmark}}
\fancyfoot[C]{\scriptsize\today\hspace{5mm}\currenttime}
}

\fancypagestyle{rppdraft}{%
\fancyhf{}
\renewcommand{\@chapapp}{}
\setlength{\headheight}{14pt}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[L]{\thepage}
\fancyhead[C]{\bf\itshape\nouppercase{\leftmark}}
\fancyfoot[C]{\scriptsize DRAFT \scriptsize\today\hspace{2mm}\currenttime - Not for public distribution}
}

\fancypagestyle{rppbooklet}{%
\fancyhf{} % clear the fields
\renewcommand{\@chapapp}{}
\renewcommand{\headrulewidth}{0pt}
\setlength{\headheight}{14pt}
\fancyhead[LE]{\thepage\xspace\xspace\xspace\bf\itshape\nouppercase{\leftmark}}
\fancyhead[RO]{{\bf\itshape\nouppercase{\leftmark}}\xspace\xspace\xspace\thepage}
\fancyhead[RE,LO]{}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Book specific formatting
\ifrppbook
\setlength{\columnsep}{5 mm}
\RequirePackage[outer=.625in,inner=1in,top=1.125in,bottom=1.0cm]{geometry}
%%% Make first page footers/headers the same as others
\fancypagestyle{plain}{}
\pagestyle{rppbook}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Web specific formatting
\ifrppweb
\RequirePackage[left=1in,right=1in,top=1in,bottom=1in]{geometry}
\ifdefined\isdraft
\fancypagestyle{plain}{}
\pagestyle{rppdraft}
\else
\fancypagestyle{plain}{%
\fancyfoot[C]{\scriptsize \rppCitation \\ \scriptsize\today\hspace{2mm}\currenttime}
}
\pagestyle{rppweb}
\fi
\fi

\ifrppbooklet
%\RequirePackage[total={76mm,147mm}]{geometry}
%\setlength{\textfloatsep}{0.1cm}
%\setlength{\intextsep}{0.1mm}
\setlength\abovecaptionskip{-4pt}
\RequirePackage[paperwidth=120mm,paperheight=200mm,top=3mm,outer=3mm,inner=19mm,bottom=5mm,includehead,headsep=2mm]{geometry}
\fancypagestyle{plain}{}
\pagestyle{rppbooklet}
\fi

%\RequirePackage[]{thumbs}

% Fix problem with "LaTeX Error: Too many unprocessed floats." on older LaTeX installations
% See https://tex.stackexchange.com/questions/46512/too-many-unprocessed-floats
\RequirePackage{morefloats}
\RequirePackage[section]{placeins}

% Use hyperref, but hide the ugly green boxes.  Also try to suppress warnings
% related to math symbols in PDF bookmarks
% Disable hyperref in booklet mode due to conflicts with xcite
\ifdefined\nohyperref
\RequirePackage{url}
\newcommand{\href[1]}{\tt{#1}}
%\relax
\else
 \RequirePackage{hyperref}
 \hypersetup{
     colorlinks=false,
     pdfborder={0 0 0},
 }
 \PassOptionsToPackage{pdfencoding=auto,psdextra, unicode, naturalnames}{hyperref}
 \pdfstringdefDisableCommands{%
   \def\pi{pi}%
   \def\eta{eta}%
 }
\fi

%%% Define some useful macros for authors to use

\input{pdgdefs}
\endinput

