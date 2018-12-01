LATEX=pdflatex
PYTHON=python3.7

.DEFAULT_GOAL := render

render: tex/resume.tex tex/pgresume.cls
	mkdir -p output
	TEXINPUTS=::tex $(LATEX) -interaction=nonstopmode -output-directory output/ tex/resume.tex

clean:
	rm -rf output/
