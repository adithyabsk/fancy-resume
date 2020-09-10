# Source: https://www.drewsilcock.co.uk/using-make-and-latexmk
LATEX=xelatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pdf
CONTINUOUS=-pvc

MAIN=resume
SOURCES=$(MAIN).tex Makefile
SECTIONS=$(wildcard sections/*.tex)
IMAGES := $(shell find images/* -type f)

.PHONY: all indent clean lint once debug

all: $(MAIN).pdf

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES) $(IMAGES)
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		-pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)

force:
	touch .refresh
	rm $(MAIN).pdf
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

indent: $(MAIN).tex $(SECTIONS)
	for file in $?; do \
		echo "Processing $$file"; \
	    latexindent -s $$file -o $$file; \
	done

clean:
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk *.bak*

lint: |
	make indent
	# This is commented out because lacheck has a bug with nested brackets in \newcommand
	# https://tex.stackexchange.com/q/471596
	# The issue was raised in the TeX mailing list but there has not been activity on that issue
	# in a year.
	# https://tug.org/pipermail/tex-live/2019-January/043083.html
	# ./lacheck_wrapper.sh $(MAIN).tex
	./chktex_wrapper.sh $(MAIN).tex

once:
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

debug:
	$(LATEX) $(LATEXOPT) $(MAIN)