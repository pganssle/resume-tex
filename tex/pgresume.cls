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

%%%%%%%%%
% Set up header
\RequirePackage{fancyhdr}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{xcolor}

\AtBeginDocument{%
%%%%%%%%
%% Default variable declarations
\providecommand{\authoremail}{}
\providecommand{\authorphone}{}
\providecommand{\authorwebsite}{}

%%%%%
% Header
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\Large\@author}
\fancyhead[R]{
    \begin{tabular}{r}
        \authorphone{} \textperiodcentered\ \authoremail{} \\
        \authorwebsite{}
    \end{tabular}}

%%%%%
% Section formatting
\titleformat{\section}[block]
    {\normalfont\large\color{white}}
    {}
    {0em}
    {\colorbox{black}}
    [\color{black}{\vspace{-1.5pt}\titlerule[1.5pt]}]

}
