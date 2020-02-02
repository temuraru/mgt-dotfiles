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


# daysListInMonth month [year [startDay]]
# Ex: $(daysListInMonth 2) -> 2020-02-01 ... 2020-02-29
# $(daysListInMonth 2 2021) -> 2021-02-01 ... 2021-02-28
# $(daysListInMonth 5 2021 6) -> 2021-05-06 ... 2021-05-31
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
