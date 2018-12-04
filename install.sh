#!/bin/bash
#
# Symlink program to a custom directory, /usr/local/bin by default

PREFIX="$1"

if [ -z "$1" ]; then
    PREFIX="/usr/local/bin"
fi

ln -sf "$(pwd)"/texcheck.sh "$PREFIX"/texcheck
