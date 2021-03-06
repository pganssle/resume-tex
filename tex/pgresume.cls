\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pgresume}

% Based on the article class
\LoadClass{article}

% Configure margins
\usepackage[a4paper,
margin=1.5cm,
top=2.5cm,
headheight=2cm,
headsep=0.25cm]{geometry}

% Set up fonts
\usepackage{fontspec}
\setmainfont[
    Ligatures=TeX,
    FontFace = {sb}{n}{Frutiger Next Pro Medium},
]{Frutiger Next Pro}

\setmonofont{Source Code Pro}

% Set up commands
\DeclareRobustCommand{\sbseries}{\fontseries{sb}\selectfont}
\DeclareTextFontCommand{\textsb}{\sbseries}

\newcommand{\pdflink}[1]{\href{#1}{%
    \raisebox{-0.15\baselineskip}{%
        \includegraphics[height=0.9\baselineskip]{images/pdf-icon.pdf}
    }%
}}

\newcommand{\githublink}[1]{\href{https://github.com/#1}{%
        \raisebox{-1.5pt}{%
        \includegraphics[height=9pt]{images/github-icon.pdf}} %
        \textsb{#1}%
}}

%%%%%%%%%
% Set up header
\RequirePackage{fancyhdr}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{enumitem}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}

\AtBeginDocument{%
%%%%%%%%
%% Default variable declarations
\providecommand{\authoremail}{}
\providecommand{\authorphone}{}
\providecommand{\authorwebsite}{}
\providecommand{\authorgithub}{}

\definecolor{linkcolor}{RGB}{26,65,130}
\newcommand{\oneortwodot}[2]{
    #1 \textperiodcentered{} #2
}

\hypersetup{%
    urlcolor=linkcolor, %
    urlbordercolor=linkcolor, %
    linkcolor=linkcolor, %
    linkbordercolor=linkcolor, %
    pdfborderstyle={/S/U/W 0.5},%
    pdfauthor=\@author %
}

%%%%%
% Header
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\fontsize{26pt}{26pt}\selectfont\textbf{\@author}\normalfont}
\fancyhead[R]{
    {\hypersetup{urlcolor=black,urlbordercolor=black,pdfborderstyle={}}
        \normalfont
    \begin{tabular}{r}
        \oneortwodot{\authorphone{}}{\authoremail{}} \\
        \oneortwodot{\githublink{\authorgithub{}}}{\authorwebsite{}}
    \end{tabular}
    }
}

%%%%%
% Section formatting
\newcommand{\sectiontitlebox}[1]{\colorbox{black}{\parbox{0.4\textwidth}{#1}}}

\titlespacing*{\section}{0pt}{-0.5\baselineskip}{0.25\baselineskip}
\titleformat{\section}[block]
    {\normalfont\large\color{white}}
    {}
    {0em}
    {\sectiontitlebox}
    [\color{black}{\vspace{-1.5pt}\titlerule[1.5pt]}]

%%%%%
% Itemize formatting
\setlist[itemize]{leftmargin=*, nosep}

%%%%%
% General
\setlength{\parindent}{0pt}
}
