\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pgresume}

% Based on the article class
\LoadClass{article}

% Configure margins
\usepackage[a4paper,
margin=1.5cm,
top=2.5cm,
headheight=2cm]{geometry}

% Set up fonts
\usepackage{fontspec}
\setmainfont[
    Ligatures=TeX,
]{Frutiger Next Pro}


% Set up commands
\newcommand{\pdflink}[1]{\href{#1}{%
    \raisebox{-0.15\baselineskip}{%
        \includegraphics[height=0.9\baselineskip]{images/pdf-icon.pdf}
    }%
}}

%%%%%%%%%
% Set up header
\RequirePackage{fancyhdr}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{enumitem}
\RequirePackage{graphicx}

\AtBeginDocument{%
%%%%%%%%
%% Default variable declarations
\providecommand{\authoremail}{}
\providecommand{\authorphone}{}
\providecommand{\authorwebsite}{}

\definecolor{linkcolor}{RGB}{26,65,130}

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
\fancyhead[L]{\fontsize{24pt}{24pt}\selectfont\textbf{\@author}\normalfont}
\fancyhead[R]{
    {\hypersetup{urlcolor=black,urlbordercolor=black}
    \begin{tabular}{r}
        \authorphone{} \textperiodcentered\ \authoremail{} \\
        \authorwebsite{}
    \end{tabular}
    }
}

%%%%%
% Section formatting
\titlespacing*{\section}{0pt}{-0.5\baselineskip}{0.25\baselineskip}
\titleformat{\section}[block]
    {\normalfont\large\color{white}}
    {}
    {0em}
    {\colorbox{black}}
    [\color{black}{\vspace{-1.5pt}\titlerule[1.5pt]}]

%%%%%
% Itemize formatting
\setlist[itemize]{leftmargin=*, nosep}

%%%%%
% General
\setlength{\parindent}{0pt}
}
