.PHONY: all distclean clean latexmk-recursive distclean-recursive clean-recursive

TEXFILES=$(wildcard *.tex)
TARGETS=$(patsubst %.tex,%.pdf,$(TEXFILES))
TEX_DIRECTORIES=$(sort $(dir $(wildcard */*.tex)))

# '-recursive' rules are based on a Makefile by Santiago Gonzalez Gancedo
# https://github.com/sangonz/latex_makefile
# which was a modified version of a Makefile by Johannes Ranke,
# which was based on Makesfiles by Tadeusz Pietraszek

all: latexmk-recursive
distclean: distclean-recursive
clean: clean-recursive

latexmk-recursive:
	for dir in $(TEX_DIRECTORIES); do \
		echo '******** starting latexmk ********'; \
		cd $$dir; \
		echo $$dir; \
		latexmk -shell-escape -quiet -pdf *.tex; \
		echo '******** finished latexmk ********'; \
		cd ..; \
	done

distclean-recursive:
	for dir in $(TEX_DIRECTORIES); do \
		cd $$dir; \
		latexmk -quiet -C *.tex; \
		cd ..; \
	done

clean-recursive:
	for dir in $(TEX_DIRECTORIES); do \
		cd $$dir; \
		latexmk -quiet -c *.tex; \
		cd ..; \
	done
