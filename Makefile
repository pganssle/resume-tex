LATEX=xelatex
PYTHON=python3.7

.DEFAULT_GOAL := render

.venv: requirements.txt
	if [ ! -d ".venv" ]; then $(PYTHON) -m virtualenv .venv; fi
	(\
		source .venv/bin/activate; \
		pip install -r requirements.txt; \
	)


output/resume.tex: .venv tex/pgresume.cls tex/resume.tex data/cv_contents.yml data/personal_data.yml  data/config.yml
	(\
		source .venv/bin/activate; \
		python -m resume_builder; \
	)

render: output/resume.tex
	TEXINPUTS=::tex $(LATEX) -interaction=nonstopmode -output-directory output/ output/resume.tex

clean:
	rm -rf output/
	rm -rf .venv
