.PHONY: clean

all: Output/Meyer_CV.pdf Output/MajorEquipment.pdf Output/FacilitiesResources.pdf

Output/Meyer_CV.pdf: Meyer_CV.md CV-templ.tex
	mkdir -p Output
	pandoc --template=CV-templ.tex --pdf-engine=pdflatex Meyer_CV.md -o $@

Output/%.pdf: %.md
	mkdir -p Output
	pandoc --pdf-engine=pdflatex $< -o $@

clean:
	rm -rf Output
