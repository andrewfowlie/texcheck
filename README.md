<h1 align="center">
✅ texcheck
</h1>

<div align="center">
<i>Spell-check a LaTeX file and check for common typos.</i>
</div>

# Usage

    ./texcheck your_tex_file.tex
    ./texcheck -d en_GB-ize your_tex_file.tex  # use a different dictionary

You might need to install `wdiff` and `pcregrep` by e.g.,

    sudo apt install wdiff pcregrep

# Advanced usage

You can add tex commands (the arguments of which won't be spell-checked) to `commands.txt`. You should
follow the syntax described [here](http://aspell.net/0.50-doc/man-html/4_Customizing.html#SECTION00541500000000000000).

Personal, extra allowed words should be added to `allowed_words.txt`. Words that you add through aspell are automatically
added there.

# Installation
    
    sudo ./install.sh

should make a symlink to `texcheck` in `/usr/local/bin`, such that it can be invoked simply by `texcheck` from anywhere.


# Example `texcheck test.tex`

```bash
Spell check fixes
=================


\unknown{eagbe} => \unknown{Abe}


Missing space before new sentence
=================================

L3:   Missing space in a new sentence.Missing space in a new sentence
L17:  These are problematic e.g. this or i.e. that or Dr. and Prof. Whoever

Missing spaces before or after brackets
=======================================

L7:   Here is (a)missing space after bracket
L5:   Missing space before a(bracket)
L11:  Extra space before  a (bracket )
L9:   Extra space after  a ( bracket)

Extra space before footnote command
===================================

L28:  This is a misplaced footnote. \footnote{wrong}
L29:  And so is this.  \footnote{wrong}
L30:  And this\footnote{wrong}.

Inconsistent space around cite command
======================================

L33:  This citing\cite{ref} and \cite{ref} is inconsistent.
L43:  Check configuration file \cite{eagbe} \unknown{Abe}
L33:  This citing\cite{ref} and \cite{ref} is inconsistent.

Missing capital in new sentence
===============================

L13:  Missing capital in new sentence. missing capital in new sentence.
L15:  Missing capital in new sentence. different spacing.
L17:  These are problematic e.g. this or i.e. that or Dr. and Prof. Whoever
L20:  Missing capital in new sentence.
over a line break

Repeated words
==============

L23:  Repeated repeated words words on a single line
L25:  Repeated words
words across a line break

a versus an
===========

L39:  A error
L41:  An mistake

Extra space around abbreviation
===============================

L17:  These are problematic e.g. this or i.e. that or Dr. and Prof. Whoever
L17:  These are problematic e.g. this or i.e. that or Dr. and Prof. Whoever
L17:  These are problematic e.g. this or i.e. that or Dr. and Prof. Whoever
L17:  These are problematic e.g. this or i.e. that or Dr. and Prof. Whoever
```
