TEX_DIRECTORIES=$(sort $(dir $(wildcard */*.tex)))

TEXFILES=$(wildcard */*.tex)
PDFTARGETS=$(TEXFILES:.tex=.pdf)
SVGTARGETS=$(PDFTARGETS:.pdf=.svg)

.PHONY: all
all: svgs gif

.PHONY: pdfs
pdfs: $(PDFTARGETS)

.PHONY: svgs
svgs: $(SVGTARGETS)

%.pdf: %.tex
	@echo '******** starting latexmk ********'; \
	cd $(@D); \
	echo $@; \
	latexmk -shell-escape -quiet -pdf $(<F); \
	echo '******** finished latexmk ********'; \

%.svg: %.pdf
	pdf2svg $< $@
	svgo -i $@ --disable=removeViewBox --enable={sortAttrs,removeDimensions} --precision=6 --multipass --pretty --indent=4

.PHONY: gif
gif: animated/HiSPARC_animated.pdf
	convert -alpha remove -density 192 -delay 2 -loop 0 -duplicate 15,-1 animated/HiSPARC_animated.pdf -layers Optimize animated/HiSPARC_animated.gif

.PHONY: distclean
distclean:
	for dir in $(TEX_DIRECTORIES); do \
		cd $$dir; \
		latexmk -quiet -C *.tex; \
		cd ..; \
	done
	rm -f $(SVGTARGETS)
	rm -f animated/HiSPARC_animated.gif

.PHONY: clean
clean:
	for dir in $(TEX_DIRECTORIES); do \
		cd $$dir; \
		latexmk -quiet -c *.tex; \
		cd ..; \
	done
