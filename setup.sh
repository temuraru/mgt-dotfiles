#!/bin/bash

export DOTFILES=$HOME/.dotfiles
[[ -d $DOTFILES ]] || mkdir -p $DOTFILES

function setupDotFiles() {
	git clone https://github.com/temuraru/mgt-dotfiles.git $DOTFILES
	# internal .dotfiles setup: 
	# 	set symlinks (rcm/rmc?!) from $HOME to $HOME/.dotfiles
	# 	set python alias symlink to python3 by default! 
	# 	install pip utilities required for scripts, etc (pip3 and pip2, but pip3 should be first) 
		# /usr/bin/python3 -m pip install -U pylint --user
		# sudo -H pip3 install onetimepass click wheel #, etc
	[ -f $DOTFILES/setup.sh ] && chmod +x $DOTFILES/setup.sh && $DOTFILES/setup.sh
}

if [ -d $DOTFILES/.git ] 
then
	cd $DOTFILES 
	git reset --hard && git pull
	[ -f $DOTFILES/manager.sh ] && source $DOTFILES/manager.sh
else
	setupDotFiles
fi

DATE=$(date +"%Y-%m-%d_%H%M%S")
[ -f ~/.bashrc_$DATE ] && mv ~/.bashrc_$DATE ~/.bashrc_bkp_$DATE
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc_$DATE
cp $DOTFILES/backup/.bashrc ~/.bashrc
curl "https://www.temuraru.ro/bash/pingback.php?hostname=$(hostname)"

# call it with: `source <(curl -s https://www.temuraru.ro/bash/setup.sh)`