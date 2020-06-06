#!/bin/bash

export DOTFILES=$HOME/.dotfiles
[[ -d $DOTFILES ]] || mkdir -p $DOTFILES


DATE=$(date +"%Y-%m-%d_%H%M")
[ -f ~/.bashrc_$DATE ] && mv ~/.bashrc_$DATE ~/.bashrc_bkp_$DATE
cp .bashrc .bashrc_$DATE

function setupDotFiles() {
	git clone git@github.com:temuraru/mgt-dotfiles.git $DOTFILES
	# internal .dotfiles setup: 
	# 	set symlinks (rcm/rmc?!) from $HOME to $HOME/.dotfiles
	# 	set python alias symlink to python3 by default! 
	# 	install pip utilities required for scripts, etc (pip3 and pip2, but pip3 should be first) 
		# /usr/bin/python3 -m pip install -U pylint --user
		# sudo -H pip3 install onetimepass click wheel #, etc
	[ -f $DOTFILES/setup.sh ] && chmod +x $DOTFILES/setup.sh && $DOTFILES/setup.sh
}

if [ -d $DOTFILES ] 
then
	cd $DOTFILES 
	git reset --hard && git pull
	[ -f $DOTFILES/manager.sh ] && source $DOTFILES/manager.sh
else
	setupDotFiles
fi


