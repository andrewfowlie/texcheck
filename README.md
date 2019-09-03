# texcheck

Spell-check a LaTeX file and check for common typos.

# basic usage

    ./texcheck your_tex_file.tex

# advanced usage

    ./texcheck -n your_tex_file.tex  # Turn off spell-check
    ./texcheck -l en_GB-ize your_tex_file.tex  # Use a different dictionary

You can add tex commands (the arguments of which won't be spell-checked) to `commands.txt`. You should
follow the syntax described [here](http://aspell.net/0.50-doc/man-html/4_Customizing.html#SECTION00541500000000000000).

Personal, extra allowed words should be added to `allowed_words.txt`. Words that you add through aspell are automatically
added there.

# installation

    sudo ./install.sh

should make a symlink to `texcheck` in `\usr\local\bin`, such that it can be invoked simply by `texcheck` from anywhere.

You might need to install `wdiff`and `pcregrep` by e.g.,

    sudo apt install wdiff pcregrep

# example `texcheck TEST`

     ------------------------------------
    |                                    |
    | Spelling with en_GB-ise dictionary |
    |                                    |
     ------------------------------------

     texcheck. => toxic.

     linebreak => linebacker

     \unknown{eagbe} => \unknown{eager}

     ------------------------
    |                        |
    | Warnings from TEST.blg |
    |                        |
     ------------------------
    Error - cannot access TEST.blg. No such file.
     -------------------------------
    |                               |
    | Missing space in new sentence |
    |                               |
     -------------------------------
      3:	Missing space in a new sentence.Missing space in a new sentence
     --------------------------------
    |                                |
    | Missing spaces around brackets |
    |                                |
     --------------------------------
      7:	)Missing space after bracket
      5:	Missing space before bracket(
     ---------------------------------
    |                                 |
    | Missing capital in new sentence |
    |                                 |
     ---------------------------------
      9:	Missing capital in new sentence. missing capital in new sentence.
      11:	Missing capital in new sentence. different spacing.
      13:	Missing capital in new sentence.
    over a linebacker
     ----------------
    |                |
    | Repeated words |
    |                |
     ----------------
      16:	Repeated repeated words words on a single line
      18:	Repeated words
    words across a line break
     ------------------
    |                  |
    | Footnote spacing |
    |                  |
     ------------------
     21:	This is a misplaced footnote. \footnote{wrong}
     22:	And so is this.  \footnote{wrong}
     23:	And this\footnote{wrong}.
     ---------------
    |               |
    | \cite spacing |
    |               |
     ---------------
     26:	This citing\cite{ref} and \cite{ref} is inconsistent.
     26:	This citing\cite{ref} and \cite{ref} is inconsistent.
     -------------
    |             |
    | a versus an |
    |             |
     -------------
     32:	A error
     34:	An mistake
