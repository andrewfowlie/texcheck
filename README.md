# texcheck

Spell-check a LaTeX file and check for common typos.

# basic usage

    ./texcheck.sh your_tex_file.tex

# advanced usage

    ./texcheck.sh -n your_tex_file.tex  # Turn off spell-check
    ./texcheck.sh -l en_GB-ize your_tex_file.tex  # Use a different dictionary

You can add tex commands (the arguments of which won't be spell-checked) to `commands.txt`. You should
follow the syntax described [here](http://aspell.net/0.50-doc/man-html/4_Customizing.html#SECTION00541500000000000000).

Personal, extra allowed words should be added to `allowed_words.txt`. Words that you add through aspell are automatically
added there.
