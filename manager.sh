#!/usr/bin/env bash
[ -f $DOTFILES/.bash/.bash_colors ] && source $DOTFILES/.bash/.bash_colors
[ -f $DOTFILES/bash.local ] && source $DOTFILES/bash.local
[ -d $DOTFILES/scripts ] && chmod 764 $DOTFILES/scripts/*
[ -f $DOTFILES/scripts/include-helpers.sh ] && $DOTFILES/scripts/include-helpers.sh
[ -f $DOTFILES/scripts/monthly-journal.sh ] && $DOTFILES/scripts/monthly-journal.sh

#[ -f $DOTFILES/.bash_aliases ] && source $DOTFILES/.bash_aliases
[ -f $DOTFILES/.bash/.bash_aliases ] && source $DOTFILES/.bash/.bash_aliases
#[ -f ~/git2.bashrc ] && source ~/git2.bashrc
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#[ -f $DOTFILES/.bash/.bashrc_anaconda ] && source $DOTFILES/.bash/.bashrc_anaconda
#[ -f $DOTFILES/.bash/.bashrc_movidius ] && source $DOTFILES/.bash/.bashrc_movidius
