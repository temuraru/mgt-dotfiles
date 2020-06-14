#!/usr/bin/env bash

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

DAYS_IN_CURRENT_MONTH=$(listRemainingDaysInCurrentMonth)
for i in $DAYS_IN_CURRENT_MONTH
do
	JOURNAL_MONTH_FOLDER=$(createJournalMonthFolderForDay $i)
  JOURNAL_FILENAME="$JOURNAL_MONTH_FOLDER/$i.md"
  processFile $JOURNAL_FILENAME
done

## https://www.tldp.org/LDP/abs/html/string-manipulation.html
