#!/bin/bash
# Spell check a LaTeX file.

if [ -z "$1" ]
  then
    echo "No file name supplied."
    exit
fi

# Check spelling with aspell.
# English dictionary.
# p (o) - Skip (optional) argument.
# P (O) - Check (optional) arguemnt.
# http://aspell.net/0.50-doc/man-html/4_Customizing.html
echo -e "\e[00;31m[1]\e[00m Checking spelling."
aspell \
--mode=tex \
--master=en_GB-ise \
--home-dir='./'\
--add-tex-command='todo p' \
--add-tex-command='bibliographystyle p' \
--add-tex-command='bibliography p' \
check $1 # Finally check!              

# Check particular typos.
echo -e "\e[00;31m[2]\e[00m Checking typos."
# Missing space in new sentence.
awk '{for(i=1;i<=NF;i++){print $i}}' $1 | grep -i "\.[a-z]" $1 | grep -TEn --color -v '\.pdf' 
# Missing space after bracket.
awk '{for(i=1;i<=NF;i++){print $i}}' $1 | grep -TEni --color  "\)[a-z]\||}[a-z]" $1
# Missing capital in new sentence.
awk '{for(i=1;i<=NF;i++){print $i}}' $1 | grep -TEn --color  "\. [a-z]" $1 

# Check for repeated words.
echo -e "\e[00;31m[3]\e[00m Checking repeated words."
# On a single line.
grep -TEin --color  "\b(\w+)\b\s*\1\b" $1
# Across a linebreak.
awk '{printf("%s\n   %.5d - %.5d: ... %s ",$0, FNR,FNR+1, $NF)}' $1 | grep -TEi --color  "\.\.\. \b(\w+)\b\s*\1\b"        
