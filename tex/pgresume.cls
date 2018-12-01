\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pgresume}

% Based on the article class
\LoadClass{article}


%%%%%%%%%
% Set up header
\RequirePackage{fancyhdr}
\RequirePackage{hyperref}
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
}
