#!/bin/sh
set -e
cd $(dirname "$0")
pandoc -o content.tex content.md
mkdir -p _build
pdflatex -interaction=nonstopmode -halt-on-error -output-directory _build databases.tex 
pdflatex -interaction=nonstopmode -halt-on-error -output-directory _build databases.tex
