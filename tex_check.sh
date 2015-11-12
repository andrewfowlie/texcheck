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
    grep --color 'Warning' $BIBLOG 
fi

#
# Check for typos
#


#
# Missing space in new sentence
#

echo "# Missing space in new sentence"
awk '{for(i=1;i<=NF;i++){print $i}}' $TEX | grep -i "\.[a-z]" $TEX | grep -TEn --color -v '\.pdf' 

#
# Missing space before or after bracket
#

echo "# Missing space after bracket"
awk '{for(i=1;i<=NF;i++){print $i}}' $TEX | grep -TEni --color  "\)[a-z]" $TEX
echo "# Missing space before bracket"
awk '{for(i=1;i<=NF;i++){print $i}}' $TEX | grep -TEni --color  "[a-z]\(" $TEX

#
# Missing capital in new sentence
#

echo "# Missing capital in new sentence"
awk '{for(i=1;i<=NF;i++){print $i}}' $TEX | grep -TEn --color  "\. [a-z]" $TEX 

#
# Repeated words
#

echo "# Repeated words"
grep -TEin --color  "\b(\w+)\b\s*\1\b" $TEX
awk '{printf("%s\n   %.5d - %.5d: ... %s ",$0, FNR,FNR+1, $NF)}' $TEX | grep -TEi --color "\.\.\. \b(\w+)\b\s*\1\b"        
