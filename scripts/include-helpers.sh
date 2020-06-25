#!/usr/bin/env bash

# *********************************************
# ~/.dotfiles/scripts/include-helpers.sh
# Include all .sh scripts in the helpers folder
# *********************************************

INCLUDER_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$INCLUDER_DIR" ]]; then INCLUDER_DIR="$PWD"; fi

# . "$INCLUDER_DIR/helpers/time-calendar.sh"
# . "$INCLUDER_DIR/helpers/transfer.sh"
helperScripts="$INCLUDER_DIR/helpers/*.sh"
chmod +x `ls $INCLUDER_DIR/helpers/*.sh`
for f in $helperScripts
do
 source $f
done

scriptPath=${0%/*}
# echo "-============- Current script path: $scriptPath"

# Another alternative is to use a file dialog instead of typing the path at all:
# dialog --dselect / 20 20
