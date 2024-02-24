.PHONY: clean

all: Output/Meyer_CV.pdf Output/MajorEquipment.pdf Output/FacilitiesResources.pdf

res.cls: 
	curl -o $@ -L https://www.ctan.org/tex-archive/macros/latex/contrib/resume/res.cls

Output/Meyer_CV.pdf: res.cls Meyer_CV.md CV-templ.tex
	mkdir -p Output
	pandoc --template=CV-templ.tex --pdf-engine=pdflatex --from markdown_strict+pipe_tables Meyer_CV.md -o $@

Output/%.pdf: %.md
	mkdir -p Output
	pandoc --pdf-engine=pdflatex $< -o $@

clean:
	rm -rf Output
