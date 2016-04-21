#!/bin/bash

#
# Check a LaTeX build for bugs, including spellings and common typos
# Usage ./tex_check.sh FILE_NAME
#

TEX=$1
BASE=$(echo $TEX | cut -f 1 -d '.')
BIBLOG=$BASE.blg

if ! [ -e $TEX ]
  then
    echo "# File does not exist"
    exit
fi

#
# Check spelling with aspell - see http://aspell.net/0.50-doc/man-html/4_Customizing.html
#

echo "# Checking spelling"

aspell \
--home-dir `pwd` \
--sug-mode normal \
--mode=tex \
--master=en_GB-ise \
--add-tex-command='bibliographystyle p' \
--add-tex-command='bibliography p' \
--add-tex-command='cite p' \
--add-tex-command='ref p' \
--add-tex-command='label p' \
check $TEX # Finally check!              

#
# Check for missing bibliography items
#

if ! [ -e "$BIBLOG" ]
  then
    echo "# No BibTeX log"
  else
    echo "# Warnings from BibTeX"
    cat $BIBLOG | grep --color 'Warning' 
fi

#
# Check for typos
#


#
# Missing space in new sentence
#

echo "# Missing space in new sentence"
cat $TEX | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -i '\.[a-z]' | grep -TEn --color -v '\.pdf'  # Ignore inclusion of e.g. pdf figures 

#
# Missing space before or after bracket
#

echo "# Missing space after bracket"
detex $TEX | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -TEni --color '\)[a-z]' $TEX
echo "# Missing space before bracket"
detex $TEX | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -TEni --color '[a-z]\(' $TEX

#
# Missing capital in new sentence
#

echo "# Missing capital in new sentence"
detex $TEX | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -TEn --color '\. [a-z]' $TEX 

#
# Repeated words
#

echo "# Repeated words"
detex $TEX | awk '{if(NF){printf($0 "\n" $NF " ")}else{printf("\n")}}' | grep -TEin --color '\b(\w+)\b\s*\1\b'

#
# Footnote spacing
#      

echo "# Footnote spacing"
cat $TEX | grep -Ei --color '\. +\\footnote{' 
cat $TEX | grep -i --color '[a-z]\\footnote{' 

#
# Check \cite spacing
#

echo "# \cite spacing"
if grep -Eiq --color ' +\\cite{' $TEX && grep -iq --color '[a-z]\\cite{' $TEX; then
    cat $TEX | grep -Ei -m 1 --color ' +\\cite{' 
    cat $TEX | grep -i -m 1 --color '[a-z]\\cite{'
fi
