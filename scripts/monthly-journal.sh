#!/usr/bin/env bash

# *********************************************
# ~/.dotfiles/scripts/helpers/time-calendar.sh
# *********************************************

# echo "-============- DAYS_IN_CURRENT_MONTH: " $(daysNrForMonth)
# echo "-============- TODAY_DATE: " $(date +"%Y-%m-%d")
# echo "-============- List: " $(listRemainingDaysInCurrentMonth)

# Ex: $(sequentialDays 2) -> 2020-02-01 2020-02-03
# $(sequentialDays 3 2020-02-03) -> 2020-02-03 2020-02-04 2020-02-05
# $(sequentialDays 3 2020-02-28 /) -> 2020/02/28 2020/02/29 2020/03/01
sequentialDays() {
  num_days=${1:-1}
  start_date=$2
  separator=${3:-'-'}
  # echo "num_days: " $num_days
  # for i in `seq 1 $num_days`
  for (( c=0; c<$num_days; c++ ))
  do
      date=`date "+%Y$separator%m$separator%d " -d "${start_date} +${c} days" `
      echo -n "$date" # Use this however you want!
  done
}


# time-calendar.sh: line 38: 31 - 31 + 1: syntax error: 
# invalid arithmetic operator (error token is 31 - 31 + 1")
# 
# daysListInMonth month [year [startDay]]
# Ex: $(daysListInMonth 2) -> 2020-02-01 ... 2020-02-29
# $(daysListInMonth 2 2021) -> 2021-02-01 ... 2021-02-28
# $(daysListInMonth 5 2021 6) -> 2021-05-06 ... 2021-05-31
# $(daysListInMonth 3 2020) -> 2020-03-01 ... 2020-03-31
# date --date="2020-05-01 +36 day" +"%Y-%m-%d" -> 2020-06-06
listAllDaysInMonth() {
  CurrentMonth=$(date +"%m")
	Cmonth=${1:-$CurrentMonth}
	Cyear=${2:-"%Y"}
	CstartDay=${3:-"1"}
  DAYS_IN_CURRENT_MONTH=$(($(daysNrForMonth $Cmonth $Cyear) - $CstartDay + 1))

  sequentialDays $DAYS_IN_CURRENT_MONTH
}

# listRemainingDaysInCurrentMonth month year startDay
listRemainingDaysInCurrentMonth() {
  CurrentMonth=$(date +"%m")
  CurrentYear=$(date +"%Y")
  CurrentDay=$(date +"%d")

  listAllDaysInMonth $CurrentMonth $CurrentYear $CurrentDay
}

# https://stackoverflow.com/a/17841619/348783
# FOO=( a b c )
# Ex: join_by , a b c #a,b,c
# join_by ' , ' a b c #a , b , c
# join_by ')|(' a b c #a)|(b)|(c
# join_by ' %s ' a b c #a %s b %s c
# join_by $'\n' a b c #a<newline>b<newline>c
# join_by - a b c #a-b-c
# join_by '\' a b c #a\b\c
# join_by , "${FOO[@]}" #a,b,c
function join_by { local IFS="$1"; shift; echo "$*"; }

function join_by2 { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }

# Ex: $(daysNrForMonth 2) -> 29 (for 2020)
# $(daysNrForMonth 2 2021) -> 28
daysNrForMonth(){
  CurrentMonth=$(date +"%m")
	Cmonth=${1:-$CurrentMonth}
	Cyear=${2:-"%Y"}
  CalDateFormat="$Cmonth $Cyear"
  #echo "month: "  $cmonth  " " $cyear
  # echo "CalDateFormat: "  $CalDateFormat

  # cal 4 2013 | awk 'NF {DAYS = $NF}; END {print DAYS}' ##30
  local DAYS_NR=$(cal $(date +"$CalDateFormat") | awk 'NF {DAYS = $NF}; END {print DAYS}')

  echo $DAYS_NR
}

# cal 4 2013 | awk 'NF {DAYS = $NF}; END {print DAYS}' ##30
# DAYS_IN_CURRENT_MONTH=$(daysNrForMonth $(date +"%m") $(date +"%Y"))  ## $(cal $(date +"%m %Y") | awk 'NF {DAYS = $NF}; END {print DAYS}')

# date --date="2020-05-01 +36 day" +"%Y-%m-%d" -> 2020-06-06



# *********************************************
# ~/.dotfiles/scripts/monthly-journal.sh
# *********************************************

## Depends on global variable JOURNAL_DAILY_TEMPLATE to be defined, otherwise it fails
processFile() {
  JOURNAL_FILENAME=${JOURNAL_FILENAME:=$1}
  [ ! -f "$JOURNAL_FILENAME" ] && cd $HOME && cp $JOURNAL_DAILY_TEMPLATE $JOURNAL_FILENAME

  # add the current day to the beginning of the current file as an H1 title (# 2020-01-19)
  # extract it from the filename: [...]/daily-journal/2020-02/2020-02-05.md
  JOURNAL_TITLE="# "${JOURNAL_FILENAME:(-13):(-3)}
  FIRST_LINE=$(head -n 1 $JOURNAL_FILENAME)
  if [ "$FIRST_LINE" != "$JOURNAL_TITLE" ] # https://stackoverflow.com/a/13781217/348783
  then
  	echo "$JOURNAL_FILENAME created..."
    sed -i "1s/^/$JOURNAL_TITLE\n\n/" $JOURNAL_FILENAME
  fi
}

## Depends on global variable JOURNAL_LOCATION to be defined, otherwise it uses the current folder
createJournalMonthFolderForDay() {
  JOURNAL_MONTH_FROM_DAY=${1:0:7}
  JOURNAL_MONTH_FOLDER="$JOURNAL_LOCATION/$JOURNAL_MONTH_FROM_DAY"
  # create/check current file path
  [ ! -d "$JOURNAL_MONTH_FOLDER" ] && mkdir -p $JOURNAL_MONTH_FOLDER
  echo $JOURNAL_MONTH_FOLDER
}

# JOURNAL_LOCATION=${JOURNAL_LOCATION:="$HOME/Dropbox/Personal/boostnotes/personal/daily-journal"}
# export JOURNAL_LOCATION=$JOURNAL_LOCATION
JOURNAL_LOCATION="$HOME/Dropbox/Personal/boostnotes/personal/daily-journal"
JOURNAL_DAILY_TEMPLATE="$JOURNAL_LOCATION/template.md"
# JOURNAL_LOCATION should contain a template.md file whose content would be copied into the current day's entry/file
# skip doing anything if the template is missing
[ ! -f $JOURNAL_DAILY_TEMPLATE ] && echo "No daily template found! Exit!" && exit 0

# DAYS_IN_CURRENT_MONTH=$(listRemainingDaysInCurrentMonth)
for i in $(listRemainingDaysInCurrentMonth)
do
	JOURNAL_MONTH_FOLDER=$(createJournalMonthFolderForDay $i)
  JOURNAL_FILENAME="$JOURNAL_MONTH_FOLDER/$i.md"
  processFile $JOURNAL_FILENAME
done

## https://www.tldp.org/LDP/abs/html/string-manipulation.html
