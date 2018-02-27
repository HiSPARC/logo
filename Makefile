.PHONY: all pdfs svgs distclean clean

TEX_DIRECTORIES=$(sort $(dir $(wildcard */*.tex)))

TEXFILES=$(wildcard */*.tex)
PDFTARGETS=$(TEXFILES:.tex=.pdf)
SVGTARGETS=$(PDFTARGETS:.pdf=.svg)

# '-recursive' rules are based on a Makefile by Santiago Gonzalez Gancedo
# https://github.com/sangonz/latex_makefile
# which was a modified version of a Makefile by Johannes Ranke,
# which was based on Makesfiles by Tadeusz Pietraszek

all: svgs
pdfs: $(PDFTARGETS)
svgs: $(SVGTARGETS)

%.pdf: %.tex
	@echo '******** starting latexmk ********'; \
	cd $(@D); \
	echo $@; \
	latexmk -shell-escape -quiet -pdf $(<F); \
	echo '******** finished latexmk ********'; \

%.svg: %.pdf
	pdf2svg $< $@

distclean:
	for dir in $(TEX_DIRECTORIES); do \
		cd $$dir; \
		latexmk -quiet -C *.tex; \
		cd ..; \
	done
	rm -f $(SVGTARGETS)

clean:
	for dir in $(TEX_DIRECTORIES); do \
		cd $$dir; \
		latexmk -quiet -c *.tex; \
		cd ..; \
	done
