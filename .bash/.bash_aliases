alias aliases='less ~/.bash/.bash_aliases ~/.gitconfig'
alias vimaliass='vim ~/.bash/.bash_aliases'
# General
alias h="history|grep "
alias f="find . |grep "
alias p="ps aux |grep "
#alias o="gnome-open "
#alias open='gnome-open'
#
alias duck='du -skc * | sort -rn'
#alias chm='kchmviewer'
alias nb='nano ~/.bashrc'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias svim='sudo vim'
alias cim='vim'
alias back='cd $OLDPWD'
alias root='sudo su'
alias runlevel='sudo /sbin/init'
alias dfh='df -h'
alias gvim='gvim -geom 84x26'
# Directory navigation aliases
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias du="du -h"
alias df="df -h"
alias cd2="cd /media/temuraru/seagate2tb"
alias cd3="cd /media/temuraru/seagate3tb"
alias cd4="cd /media/temuraru/seagate4tb"
alias mkcd="mkcdir " # .bash_local: mkcdir () { mkdir -p -- "$1" && cd -P -- "$1" } # the code should be on separate lines!!!
# interactive
alias cp='cp -vi'
alias mv='mv -vi'
# System info
alias cpuu="ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'"
alias memu='ps -e -o rss=,args= | sort -b -k1,1n | pr -TW$COLUMNS'
alias pg='ps aux | grep'  #requires an argument
# Music
alias ncmpc='ncmpc -cm'
# apt
alias sai='sudo apt-get install'
alias agi='sudo apt-get install'
alias agiy='sudo apt-get install -y'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update'
alias agg='sudo apt-get upgrade'
alias acs='apt-cache search'
alias sources='gksudo gedit /etc/apt/sources.list'
# network
alias net1='watch --interval=2 "sudo netstat -apn -l -A inet"'
alias net2='watch --interval=2 "sudo netstat -anp --inet --inet6"'
alias net3='sudo lsof -i'
alias net4='watch --interval=2 "sudo netstat -p -e --inet --numeric-hosts"'
alias net5='watch --interval=2 "sudo netstat -tulpan"'
alias net6='sudo netstat -tulpan'
alias net7='watch --interval=2 "sudo netstat -utapen"'
alias net8='watch --interval=2 "sudo netstat -ano -l -A inet"'
alias netl='sudo nmap -sT -O localhost' # more here http://www.redhat.com/docs/manuals/linux/RHL-9-Manual/security-guide/s1-server-ports.html
alias ping='ping -c 10'
alias whois='whois -H'
# listings
alias ls='ls -h --color=auto'
alias lh='ls -lah'                # human readable (sizes) long and all ;-)
alias lls='ls -l -h -g -F --color="auto" '
alias lc='ls -aCF'
alias lsam='ls -am'               # List files horizontally
alias lr='ls -lR'                 # recursive
alias lsx='ls -ax'                # sort right to left rather then in columns
alias lss='ls -shAxSr'            # sort by size
alias lt='ls -lAtrh'              # sort by date and human readable
alias lm='ls -al |more'           # pipe through 'more'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dir='ls --color=auto --format=vertical'
alias vdir='vdir --color=auto --format=long'
# scripts
#
# chmod and permissions commands
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'
alias perm='stat --printf "%a %n \n "' # requires a file name e.g. perm file
# lynx web browser
alias bbc='lynx http://news.bbc.co.uk/text_only.stm'
alias nytimes='lynx http://nytimes.com'
alias dmregister='lynx http://desmoinesregister.com'
alias google='lynx http://google.com?q='
# | /var/www/$1".emag/app/console" --env="$EMAG_ENV" cache:clear'
alias cda='cd /var/www/admin.emag/'
alias cdw='cd /var/www/www.emag/'
alias cde='cd vendor/EOS/'
alias clc='rm -rf web/templates_c/*.php web/cache/js/*.js web/cache/css/*.css app/cache/*'
alias clw='cd /var/www/www.emag && clc'
# dev servers
alias cdtt='cd /var/www/teo/tgt/'
alias cdtr='cd /var/www/teo/rec/'
# live servers
alias cdtc='cd /var/www/targeting/current/'
alias cdt='cd /var/www/targeting/'
# build server
alias cdnb='cd /var/www/neos/'
alias cdrb='cd /var/www/rec/'
alias cdtb='cd /var/www/tgt/'
alias cdtgt='cd /var/www/tgt/'
alias cdr="cd /var/www/rec"
alias cdrec="cd /var/www/rec"
alias cdrc='cd /var/www/rec/current/'
alias cdnl='cd /var/www/neolane/'
alias cdnlc='cd /var/www/neolane/current/'
alias cdn='cd /var/www/neos/'
alias cdneos='cd /var/www/neos/'
alias cdnc='cd /var/www/neos/current/'
# local projects
alias dtp='cd ~/Desktop'
alias cdht='cd ~/work/projects/tgt/'
alias cdlt='cd ~/work/projects/trigger-system/'
alias cdhc='cd ~/work/projects/rec-engine-app/'
alias cdlc='cd ~/work/projects/rec-engine-app/'
#tail
alias tl='tail -f /var/log/nginx/m.emag.ro-error.log /var/log/nginx/admin.emag.ro-error.log /var/log/nginx/www.emag.ro-error.log'
alias tlf='tail -f /var/www/q.consumer/logs/error.log /var/www/q.consumer/logs/order_update_log.log /var/log/nginx/admin.emag.ro-error.log /var/log/nginx/www.emag.ro-error.log /var/log/nginx/m.emag.ro-error.log /var/www/gearman/logs/error.log /var/www/gearman/logs/workers/update_orders.log /var/www/gearman/logs/workers/vignette_order_update_worker.log'
# rm -rf web/bundles/* && php app/console assets:install && php app/console assetic:dump
alias rmass="rm -rf web/bundles/* && php app/console assets:install && php app/console assetic:dump"
alias assetic="php app/console assets:install && php app/console assetic:dump"
alias r1="echo $1"
#git
alias gs="git status"
alias gp="git pull"
alias gf="git fetch"
alias lg="git lg"
alias gti="git"
#supervisor
alias sv="supervisorctl -s 'http://127.0.0.1:8989' -u admin -p parolasupervisor1213"
alias sss="sudo supervisorctl status"
# ssh to servers
# -- TGT Build - to make deploys/run capistrano cmds from it
alias tb1="ssh tgt-build1-all-prod.emag.network"
alias tbuild="ssh tgt-build1-all-prod.emag.network"
# -- Neos dev/prod
alias np1="ssh neos-www1-all-prod.emag.network"
alias np2="ssh neos-www2-all-prod.emag.network"
alias ndev="ssh neos-all18071-all-dev.tgt.e3.c.emag.network"
# -- Tgt dev/prod
alias tdev="ssh tgt-all31497-all-dev.tgt.e3.c.emag.network"
alias rb1="ssh tgt-build1-all-prod.emag.network"
alias ts1="ssh tgt-www1-all-stage.emag.network"
alias tp1="ssh tgt-www1-all-prod.emag.network"
alias tp2="ssh tgt-www2-all-prod.emag.network"
alias tp3="ssh tgt-www3-all-prod.emag.network"
alias tp4="ssh tgt-www4-all-prod.emag.network"
alias tp5="ssh tgt-www5-all-prod.emag.network"
alias tp6="ssh tgt-www6-all-prod.emag.network"
alias tp7="ssh tgt-www7-all-prod.emag.network"
alias tp8="ssh tgt-www8-all-prod.emag.network"
alias tp9="ssh tgt-www9-all-prod.emag.network"
alias tp10="ssh tgt-www10-all-prod.emag.network"
alias tp11="ssh tgt-www11-all-prod.emag.network"
alias tp12="ssh tgt-www12-all-prod.emag.network"
alias tp13="ssh tgt-www13-all-prod.emag.network"
alias tp14="ssh tgt-www14-all-prod.emag.network"
alias tp15="ssh tgt-www15-all-prod.emag.network"
alias tp16="ssh tgt-www16-all-prod.emag.network"
# -- rec prod/stage/dev/stack
alias rdev="ssh rec-all68861-all-dev.tgt.e3.c.emag.network"
alias rp1="ssh rec-www1-all-prod.emag.network"
alias rp2="ssh rec-www2-all-prod.emag.network"
alias rp3="ssh rec-www3-all-prod.emag.network"
alias rp4="ssh rec-www4-all-prod.emag.network"
alias rp5="ssh rec-www5-all-prod.emag.network"
alias rp6="ssh rec-www6-all-prod.emag.network"
alias rp7="ssh rec-www7-all-prod.emag.network"
alias rp8="ssh rec-www8-all-prod.emag.network"
alias rp9="ssh rec-www9-all-prod.emag.network"
alias rp10="ssh rec-www10-all-prod.emag.network"
alias rp11="ssh rec-www11-all-prod.emag.network"
alias rp12="ssh rec-www12-all-prod.emag.network"
alias rp13="ssh rec-www13-all-prod.emag.network"
alias rp19="ssh rec-www19-all-prod.emag.network"
alias rp20="ssh rec-www20-all-prod.emag.network"
alias rp21="ssh rec-www21-all-prod.emag.network"
alias rp22="ssh rec-www22-all-prod.emag.network"
alias rwp1="ssh rec-worker1-all-prod.emag.network"
alias rwp2="ssh rec-worker2-all-prod.emag.network"
alias rwp3="ssh rec-worker3-all-prod.emag.network"
alias rwp4="ssh rec-worker4-all-prod.emag.network"
alias rwp5="ssh rec-worker5-all-prod.emag.network"
alias rwp6="ssh rec-worker6-all-prod.emag.network"
# -- Rec Neo4j machines (prod/stage)
alias rnp1="ssh rec-neoj1-ro-prod.emag.network"
alias rnp2="ssh rec-neoj2-ro-prod.emag.network"
alias rnp3="ssh rec-neoj3-ro-prod.emag.network"
alias rns1="ssh rec-neoj1-ro-stage.emag.network"
# ---- deprecated
alias rdev_old="ssh rec-all68861-all-dev.tgt.c.emag.network"
alias rs1_deprecated="ssh rec-ro-stage.emag.network"
alias rd1_deprecated="ssh rec-www1-all-dev.emag.network"
alias rdev1_deprecated="ssh rec-all6416-all-dev.tgt.c.emag.network"
alias rdev2_deprecated="ssh rec-all7954-all-dev.tgt.c.emag.network"
alias eos10_deprecated="ssh eos10-dev.emag.local"
# Local cmds aliases
alias lcdp="cd ~/work/projects/"
alias lcdr="cd ~/work/projects/rec-engine-app/"
alias rcdr="cd ~/work/projects/rec-engine-app/"
alias lcdt="cd ~/work/projects/trigger-system/"
alias rcdt="cd ~/work/projects/targeting/"
alias puppy="sudo /opt/puppetlabs/bin/puppet"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# To copy the current path to the clipboard you can use the following command: > pwd | xclip -sel clip
# I've created an alias to the last command: xsc. It allows me to type simpler:> pwd | xsc
alias xsc='xclip -sel clip'
alias dj="subl $JOURNAL_CURRENT_FILENAME"


##
