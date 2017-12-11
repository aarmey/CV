.PHONY: clean upload

all: Output/Meyer_CV.pdf Output/Biosketch.pdf Output/.git/HEAD

res.cls: 
	curl -o $@ -v -L https://www.ctan.org/tex-archive/macros/latex/contrib/resume/res.cls

Output/Meyer_CV.pdf: res.cls Meyer_CV.md CV-templ.tex
	mkdir -p Output
	pandoc --template=CV-templ.tex --latex-engine=xelatex Meyer_CV.md -o $@

Output/Biosketch.pdf: Biosketch.md
	mkdir -p Output
	pandoc --latex-engine=xelatex Biosketch.md -o $@

Output/.git/HEAD: Output
	cd Output; git init; git config user.name "Jenkins CI"; git config user.email "jenkins@asmlab.org"
	cd Output; git remote add upstream "git@github.com:aarmey/CV.git"; git fetch upstream; git reset upstream/gh-pages; touch .

upload: Output/.git/HEAD Output/Meyer_CV.pdf Output/Biosketch.pdf
	cd Output; git add -A .; git status
	cd Output; git commit -m "Jenkins $BUILD_NUMBER auto-pushed"; git push -q upstream HEAD:gh-pages

clean:
	rm -rf Output
