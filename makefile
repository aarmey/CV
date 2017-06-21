.PHONY: clean gitclean upload

all: Meyer_CV.pdf Biosketch.pdf Output/Meyer_CV.pdf Output/Biosketch.pdf Output/.git/HEAD

res.cls: 
	curl -o $@ -v -L https://www.ctan.org/tex-archive/macros/latex/contrib/resume/res.cls

Meyer_CV.pdf: res.cls Meyer_CV.tex
	xelatex Meyer_CV.tex

Biosketch.pdf: Biosketch.tex
	xelatex Biosketch.tex

Output/%.pdf: %.pdf
	mkdir -p Output
	cp $< $@

Output/.git/HEAD: Output
	cd Output; git init; git config user.name "Jenkins CI"
	cd Output; git config user.email "jenkins@asmlab.org"
	cd Output; git remote add upstream "git@github.com:thanatosmin/CV.git"
	cd Output; git fetch upstream; git reset upstream/gh-pages; touch .

upload: Output/.git/HEAD Output/Meyer_CV.pdf Output/Biosketch.pdf
	cd Output; git add -A .; git status
	cd Output; git commit -m "Jenkins $BUILD_NUMBER auto-pushed"
	cd Output; git push -q upstream HEAD:gh-pages

clean:
	rm -f res.cls *.aux *.log *.out *.pdf
	rm -rf Output

gitclean:
	git clean -ffdx