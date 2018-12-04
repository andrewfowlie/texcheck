#!/bin/bash
#
# Check a LaTeX file for spelling errors and common typos
#

#
# Parse command line
#

USE="$(basename "$0") [-h] [-n] [-l en_GB-ise] [FILE] -- spell-check a LaTeX file and check for common typos"
DICT=en_GB-ise

while getopts 'hdn' option; do
    case "$option" in
        h) echo "$USE"
           exit 1
           ;;
        d) DICT="$OPTARG"
           ;;
        n) NO_SPELL="N"
           ;;
        \?) echo "$USE"
           exit 0
           ;;
    esac
done

shift "$((OPTIND - 1))"
TEX=$1

if [ -z "$TEX" ]; then
    echo "$USE"
    exit 0
fi

if ! [ -e "$TEX" ]; then
    echo "Cannot access $TEX. No such file."
    exit 0
fi

#
# Check spelling with aspell - see http://aspell.net/0.50-doc/man-html/4_Customizing.html
#

if [ -z "$NO_SPELL" ]; then

    echo "Checking spelling"

    aspell \
    --home-dir "$(dirname $(readlink -f $0))" \
    --sug-mode normal \
    --mode=tex \
    --master="$DICT" \
    check "$TEX" # Finally check!

fi

#
# Check for missing bibliography items
#

BASE=$(echo "$TEX" | cut -f 1 -d '.')
BIBLOG=$BASE.blg

if ! [ -e "$BIBLOG" ] || [ -z "$BIBLOG" ]; then
    echo "Cannot access $BIBLOG. No such file."
else
    echo "Warnings from $BIBLOG"
    grep --color 'Warning' "$BIBLOG"
fi

#
# Missing space in new sentence
#

echo "Missing space in new sentence"
awk '{for(i=1;i<=NF;i++){print $i}}' "$TEX" | grep -i '\.[a-z]' | grep -TEn --color -v '\.pdf'  # Ignore inclusion of e.g. pdf figures

#
# Missing space before or after bracket
#

echo "Missing space after bracket"
detex "$TEX" | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -TEni --color '\)[a-z]'
echo "Missing space before bracket"
detex "$TEX" | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -TEni --color '[a-z]\('

#
# Missing capital in new sentence
#

echo "Missing capital in new sentence"
detex "$TEX" | tr '\n' ' ' | grep -oTEn --color '.{0,5}\. +[a-z].{0,50}'

#
# Repeated words
#

echo "Repeated words"
detex "$TEX" | awk '{if(NF){printf($0 "\n" $NF " ")}else{printf("\n")}}' | grep -TEin --color '\b(\w+)\b\s*\1\b'

#
# Footnote spacing
#

echo "Footnote spacing"
grep -Ei --color '\. +\\footnote{' "$TEX"
grep -i --color '[a-z]\\footnote{' "$TEX"

#
# Check \cite spacing
#

echo "\\cite spacing"
if grep -Eiq --color ' +\\cite{' "$TEX" && grep -iq --color '[a-z]\\cite{' "$TEX"; then
    grep -Ei -m 1 --color ' +\\cite{' "$TEX"
    grep -i -m 1 --color '[a-z]\\cite{' "$TEX"
fi

#
# a versus an
#

echo "a versus an"
grep -TEni --color '\ba [aeiou]' "$TEX"
grep -i '\ban [a-z]' "$TEX" | grep -TEn --color -v 'an [aeiou]'

