#!/usr/bin/env bash

## **** HOW USE THIS SCRIPT ****
##
# 1 - Log in with your credentials from the above link - https://myaccount.google.com/apppasswords
# 2 - Create an App  category-> Other give it any name(call it anything you like eg. mailterminal, bashmail)
# 3 - Now copy the password and store it MAIL_GAAP VARIABLES.
# 4 - Check SPAM folder!!!
# 5 - Now your happy
##

URL="https://ya.ru"
LOCK_FILE="/tmp/__lock_alert_file"
MAIL_RCPT="linuxhooligans@yandex.ru"
MAIL_FROM="inishev.oleg@gmail.com"
MAIL_GAAP="xxxxxxxxx"
MAIL_SUBJECT="ALERT BABY"
MAIL_BASE_TEXT="NOW YOU ARE HAVE PROBLEM"

clear_alert() {
  rm -rf $LOCK_FILE
}

generate_alert() {
  if [ -f $LOCK_FILE ]; then
    echo " exists"
  else
    echo " not exists"
    curl  -s --url 'smtps://smtp.gmail.com:465' \
    --ssl-reqd   --mail-from $MAIL_FROM \
    --mail-rcpt $MAIL_RCPT \
    --user $MAIL_FROM:$MAIL_GAAP \
    -T <(echo -e "From: ${MAIL_FROM} To: ${MAIL_RCPT} Subject:${MAIL_SUBJECT}\n${MAIL_BASE_TEXT}")
    touch $LOCK_FILE
  fi
}

STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" $URL)
case $STATUS_CODE in
  200)
    echo "GOOD"
    clear_alert
  ;;
  *)
    echo "OOPS"
    generate_alert
  ;;
esac
