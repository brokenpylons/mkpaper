project="${1?Missing project name}"

tee Dockerfile <<EOF
FROM brokenpylons/lualatex-build:v0.0.4
EOF

tee Makefile <<EOF
project = ${project}

.PHONY: all clean

all: \$(project).pdf

\$(project).pdf: \$(project).tex Dockerfile
	latexmk -g $< </dev/null

clean:
	latexmk -C
EOF

tee "${project}.tex" <<EOF
\documentclass{article}
\title{Title}
\author{Author}
\date{\today}

\begin{document}
\maketitle

\section{Section}
Text

\end{document}
EOF
