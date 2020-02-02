#!/usr/bin/env bash

# *********************************************
# ~/.dotfiles/scripts/include-helpers.sh
# *********************************************
INCLUDER_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$INCLUDER_DIR" ]]; then INCLUDER_DIR="$PWD"; fi
. "$INCLUDER_DIR/helpers/time-calendar.sh"

scriptPath=${0%/*}
#echo "-============-1" $scriptPath

# Another alternative is to use a file dialog instead of typing the path at all:
# dialog --dselect / 20 20
