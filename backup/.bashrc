umask 0002
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ ! "$TERM" = "" ]; then
	export TERM=xterm
	# export TERM=xterm-256color
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html -> http://bashish.sourceforge.net/index.html
# https://bneijt.nl/blog/post/add-a-timestamp-to-your-bash-prompt/
PS1="[\D{%F %T}] $PS1"

# https://zwischenzugs.com/2019/05/11/seven-surprising-bash-variables/
PROMPT_COMMAND='echo -n "Command #$LINENO. Shell #$SHLVL. Last command run at " && date '

# better history
HISTTIMEFORMAT='%F %T ' >/dev/null 2>/dev/null # || echo "HISTTIMEFORMAT is readonly!" # HISTTIMEFORMAT='I ran this at: %y-%m-%d %T '
HISTIGNORE='ls:bg:fg:history' >/dev/null 2>/dev/null # || echo "HISTTIMEFORHISTIGNOREMAT is readonly!"
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1) - append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# not used yet.... work in progress!
function setupDotFiles() {
	mkdir -p $DOTFILES && cd $DOTFILES/
	git clone https://github.com/temuraru/mgt-dotfiles.git .
	# git clone git@github.com:temuraru/mgt-dotfiles.git .
	# internal .dotfiles setup: 
	# 	set symlinks (rcm/rmc?!) from $HOME to $HOME/.dotfiles
	# 	set python alias symlink to python3 by default! 
	# 	install pip utilities required for scripts, etc (pip3 and pip2, but pip3 should be first) 
		# /usr/bin/python3 -m pip install -U pylint --user
		# sudo -H pip3 install onetimepass click wheel #, etc
	[ -f $DOTFILES/setup.sh ] && chmod +x $DOTFILES/setup.sh && $DOTFILES/setup.sh
}

# import various config files
export DOTFILES=$HOME/.dotfiles
if [ -d $DOTFILES ] 
then
	[ -f $DOTFILES/manager.sh ] && source $DOTFILES/manager.sh
else
	setupDotFiles
fi
