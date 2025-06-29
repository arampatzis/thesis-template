\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis-uoc}[2025/06/29 Thesis class for University of Crete]

% Boolean setup
\RequirePackage{ifthen}
\newboolean{language@set}  \setboolean{language@set}{false}
\newboolean{@english}      \setboolean{@english}{true}
\newboolean{@greek}        \setboolean{@greek}{false}

% Language options
\DeclareOption{greek}{%
  \PassOptionsToPackage{greek}{babel}
  \setboolean{language@set}{true}
  \setboolean{@greek}{true}
  \setboolean{@english}{false}
}
\DeclareOption{english}{%
  \PassOptionsToPackage{english}{babel}
  \setboolean{language@set}{true}
  \setboolean{@english}{true}
  \setboolean{@greek}{false}
}

% Pass unknown options to report class
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}
}
\ProcessOptions

% Load base class
\LoadClass[12pt,a4paper,twoside]{report}

% Load babel if language set
\ifthenelse{\boolean{language@set}}{%
  \RequirePackage{babel}%
}{%
  \RequirePackage[english]{babel}% fallback
}

% Geometry and spacing
\RequirePackage{geometry}
\geometry{
  a4paper,
  total={160mm,260mm},
  left=25mm,
  right=25mm,
  top=20mm,
  bottom=20mm
}
\RequirePackage{setspace}
\onehalfspacing

% Reduce underfull vbox warnings
\vbadness=5000
\raggedbottom

% Header/footer
\RequirePackage{fancyhdr}
\setlength{\headheight}{15pt}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\thepage}
\fancyhead[RE]{\nouppercase{\leftmark}}
\fancyhead[LO]{\nouppercase{\rightmark}}

% Custom cleardoublepage that makes blank pages empty
\newcommand{\cleardoubleemptypage}{%
  \clearpage
  \ifodd\value{page}\else
    \thispagestyle{empty}%
    \mbox{}%
    \clearpage
  \fi
}

% Title formatting
\RequirePackage{titlesec}
\titleformat{\chapter}
  [display]
  {\normalfont\bfseries\Huge}
  {\chaptername\ \thechapter}
  {20pt}
  {\Huge}

% Essential packages
\RequirePackage{microtype}
\RequirePackage{parskip}
\RequirePackage[pdftex]{graphicx}
\RequirePackage{color}
\RequirePackage{xcolor,colortbl}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{amsmath,amsthm,amssymb}
\RequirePackage{mathtools}
\RequirePackage{commath}
\RequirePackage{bm}
\RequirePackage{bbm}
\RequirePackage[c]{esvect}
\RequirePackage{upgreek}
\RequirePackage{csquotes}
\RequirePackage[style=numeric,backend=biber,sorting=none]{biblatex}
\RequirePackage{hyperref}
\RequirePackage[capitalise]{cleveref}

% Theorem environments
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}

% Mathematical operators
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}

% Probability and statistics notation
\RequirePackage{xparse}
\newcommand{\Real}{\mathbb{R}}
\newcommand{\Uniform}{\mathcal{U}}
\newcommand{\Normal}{\mathcal{N}}

\DeclareDocumentCommand{\Mean}{o o}
{%
  \IfNoValueTF{#2}{
    \IfNoValueTF{#1}{
        \mathbb{E}\,
    }{
        \mathbb{E}_{#1}
    }
  }
  {
    \mathbb{E}_{#1} \left[ #2 \right]
  }
}

\DeclareDocumentCommand{\Prob}{o o}
{%
  \IfNoValueTF{#2}{
    \IfNoValueTF{#1}{
        \mathbb{P}\,
    }{
        \mathbb{P}_{#1}
    }
  }
  {
    \mathbb{P}_{#1} \left( #2 \right)
  }
}

\DeclareDocumentCommand{\Var}{o o}
{%
  \IfNoValueTF{#2}{
    \IfNoValueTF{#1}{
        \mathbb{V}\,
    }{
        \mathbb{V}_{#1}
    }
  }
  {
    \mathbb{V}_{#1} \left[ #2 \right]
  }
}

% Thesis metadata commands
\newcommand{\university}{University of Crete}
\newcommand{\department}{Dept. of Applied Mathematics}
\ifthenelse{\boolean{@greek}}{%
  \newcommand{\thesistype}{\selectlanguage{greek}Διπλωματική Εργασία}%
}{%
  \newcommand{\thesistype}{Master's Thesis}%
}
\newcommand{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand{\studentname}[1]{\def\@studentname{#1}}
\newcommand{\thesistitle}[1]{\def\@thesistitle{#1}}
\newcommand{\thesisdate}[1]{\def\@thesisdate{#1}}
\newcommand{\thesislogo}[1]{\def\@thesislogo{#1}}
\def\@thesislogo{} % Default: no logo

% Title page
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \centering
    \vspace*{2cm}
    {\Huge \@thesistitle \par}
    \vspace{2cm}
    {\Large \thesistype \par}
    \ifx\@thesislogo\empty
      \vspace{2cm}
    \else
      \vspace{2cm}
      \includegraphics[height=3cm]{\@thesislogo}
      \vspace{1cm}
    \fi
    \vfill
    {\large \@studentname \par}
    {\large Supervisor: \@supervisor \par}
    \vspace{1cm}
    {\large \department \par}
    {\large \university \par}
    {\large \@thesisdate \par}
  \end{titlepage}
  \thispagestyle{empty}
}

% Acknowledgments environment
\newcommand{\acknowledgments}{%
  \cleardoubleemptypage
  \ifthenelse{\boolean{@greek}}{%
    \chapter*{Ευχαριστίες}%
    \addcontentsline{toc}{chapter}{Ευχαριστίες}%
  }{%
    \chapter*{Acknowledgments}%
    \addcontentsline{toc}{chapter}{Acknowledgments}%
  }%
  \thispagestyle{empty}
}

% Abstract environment
\newcommand{\abstractsection}{%
  \cleardoubleemptypage
  \ifthenelse{\boolean{@greek}}{%
    \chapter*{Περίληψη}%
    \addcontentsline{toc}{chapter}{Περίληψη}%
  }{%
    \chapter*{Abstract}%
    \addcontentsline{toc}{chapter}{Abstract}%
  }%
  \thispagestyle{empty}
}

% Committee environment
\newcommand{\committeesection}[1]{%
  \cleardoubleemptypage
  \ifthenelse{\boolean{@greek}}{%
    \chapter*{Επιτροπή}%
    \addcontentsline{toc}{chapter}{Επιτροπή}%
  }{%
    \chapter*{Committee}%
    \addcontentsline{toc}{chapter}{Committee}%
  }%
  \thispagestyle{empty}
  \begin{center}
    \large
    \begin{tabular}{c}
      #1
    \end{tabular}
  \end{center}
}

% Dedication environment
\newcommand{\dedication}[1]{%
  \cleardoubleemptypage
  \thispagestyle{empty}
  \null\vfill
  \begin{center}
    \Large\textit{#1}
  \end{center}
  \vfill
  \null
}

% Language display command
\ifthenelse{\boolean{@greek}}{%
  \newcommand{\langname}{Greek}%
}{%
  \newcommand{\langname}{English}%
}

