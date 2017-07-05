# -----------------------
# Modelo de Memoria para
# Trabajo Fin de Máster
# Máster Universitario en Ingeniería Informática
#
# http://www.ull.es/view/master/ingenieriainformatica/Inicio/es
# 
# by F. de Sande
# date: 28.05.2015
# ---
##### User configurable options #####
LATEX    = latex
BIBTEX   = bibtex
PDFLATEX = pdflatex
DVIPS    = dvips
L2HTML   = latex2html
LATEX2HTMLOPTIONS = -html_version 4.0,latin1,unicode -contents_in_navigation -white -local_icons
PLOT     = gnuplot
SRC      = TFM.tex
MASSRC   = TFM.tex
SRCIDX   = TFM.idx
MAKEINDEX= makeindex
DVI	     = $(SRC:.tex=.dvi)
BIB	     = $(SRC:.tex=.bib)
PS	     = $(SRC:.tex=.ps)
SRCSIN   = $(SRC:.tex=)
### End User configurable options ###

default: pdf

all:
	$(MAKE) ps

pdf: $(SRC)
	$(RM) *.dvi *.bbl *.aux *.toc *.lof *.lot *.log *.blg *.out *~ basura* HTML/* *.nav *.snm *.vrb *.idx *.ind *.ilg
	$(RM) tex/*.aux tex/*~
	$(PDFLATEX) $(SRC) && $(PDFLATEX) $(SRC) && $(PDFLATEX) $(SRC) && $(MAKEINDEX) $(SRCIDX) && $(BIBTEX) TFM && $(PDFLATEX) $(SRC) && $(PDFLATEX) $(SRC) && $(PDFLATEX) $(SRC)
	
html: $(PS)
	$(L2HTML) -dir HTML -split 4 -local_icons -long_titles 20 $(SRC)

latex2html:
	$(L2HTML) $(LATEX2HTMLOPTIONS) $(MASSRC)

ps: $(DVI)
	$(DVIPS) -o $(PS) $(DVI)

clean:
	$(RM) *.dvi *.bbl *.aux *.toc *.lof *.lot *.log *.blg *.out *~ basura* HTML/* *.nav *.snm *.vrb *.idx *.ind *.ilg
	$(RM) tex/*.aux tex/*~
delete:
	$(MAKE) clean; $(RM) *~ $(SRCSIN).pdf $(SRCSIN).ps

%.dvi: %.tex
#	$(LATEX) $(SRC) && $(MAKE) bib && $(LATEX) $(SRC) && $(LATEX) $(SRC)
	$(LATEX) $(SRC) 
	
# end
# --