# *********************************************
# ~/.dotfiles/scripts/daily-journal.sh
# *********************************************

# read the JOURNAL_DAILY_LOCATION shell variable or use a default value
# https://stackoverflow.com/a/2013589/348783
JOURNAL_DAILY_LOCATION=${JOURNAL_DAILY_LOCATION:='Dropbox/Personal/boostnotes/personal/daily-journal'}
export JOURNAL_DAILY_LOCATION=$JOURNAL_DAILY_LOCATION
# JOURNAL_DAILY_LOCATION should contain a template.md file
# whose content would be copied to the current day's entry
JOURNAL_DAILY_TEMPLATE="$JOURNAL_DAILY_LOCATION/template.md"
# skip doing anything if the template is missing
[ ! -f $JOURNAL_DAILY_TEMPLATE ] && exit 0

# curent month
JOURNAL_CURRENT_MONTH="$(date +'%Y-%m')" # "$(date +'%F')"
JOURNAL_MONTHLY_FOLDER=$JOURNAL_DAILY_LOCATION/$JOURNAL_CURRENT_MONTH
# create/check current file path
[ ! -d "$JOURNAL_MONTHLY_FOLDER" ] && mkdir -p $JOURNAL_MONTHLY_FOLDER

# create day/file
JOURNAL_CURRENT_DAY="$(date +'%Y-%m-%d')" # "$(date +'%F')"
JOURNAL_CURRENT_TITLE="# $JOURNAL_CURRENT_DAY"
JOURNAL_CURRENT_FILENAME="$JOURNAL_MONTHLY_FOLDER/$JOURNAL_CURRENT_DAY.md"
export JOURNAL_CURRENT_FILENAME=$JOURNAL_CURRENT_FILENAME


[ ! -f "$JOURNAL_CURRENT_FILENAME" ] && cd ~ && cp $JOURNAL_DAILY_TEMPLATE $JOURNAL_CURRENT_FILENAME

# add the current day to the beginning of the current file as an H1 title (# 2020-01-19)
FIRST_LINE=$(head -n 1 $JOURNAL_CURRENT_FILENAME)
if [ "$FIRST_LINE" != "$JOURNAL_CURRENT_TITLE" ] # https://stackoverflow.com/a/13781217/348783
then
	echo "$JOURNAL_CURRENT_FILENAME created..."
  sed -i "1s/^/$JOURNAL_CURRENT_TITLE\n\n/" $JOURNAL_CURRENT_FILENAME
fi
