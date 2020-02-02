



function apt-updater {
	apt-get update &&
	apt-get dist-upgrade -Vy &&
	apt-get autoremove -y &&
	apt-get autoclean &&
	apt-get clean &&
	reboot
}

cheat() { 
	curl "http://cheat.sh/$1"
}

man2txt() {
	man "$1" | col -bx
}

manflags(){
	man "$1" | awk '{$1=$1;print}' | grep "^\-"
} #man pages just the flags more or less, captures some extra 

ubuman() { 
	w3m -dump "https://manpages.ubuntu.com/manpages/bionic/en/man1/"$1".1.html"
} # ubuntu web manpages note bionic, update with do release up

ubumanflags() { 
	w3m -dump "https://manpages.ubuntu.com/manpages/bionic/en/man1/$1.1.html" | \
	awk '{$1=$1;print}' | grep "^\-"
} # ubuntu web manpages

explain () {
	if [ "$#" -eq 0 ]; then
	  while read  -p "Command: " cmd; do
	    curl -Gs "https://www.mankier.com/api/v2/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
	  done
	  echo "Bye!"
	elif [ "$#" -eq 1 ]; then
	  curl -Gs "https://www.mankier.com/api/v2/explain/?cols="$(tput cols) --data-urlencode "q=$1"
	else
	  echo "Usage"
	  echo "explain                  interactive mode."
	  echo "explain 'cmd -o | ...'   one quoted command to explain it."
	fi
}