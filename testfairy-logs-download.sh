#!/bin/bash

function print_help() {
  echo
  echo "Usage: $0 app build last-session-id start-session-id"
  echo "  app              - app id (the value after /project/)"
  echo "  build            - build id (the value after /builds/)"
  echo "  last-session-id  - the largest session number for this build"
  echo "  start-session-id - the lowest session number for this build to fetch. Default is 1"
  echo "  help             - print this help"
  echo
  echo "In order to get config parameters, go to the page with list of session you want to download and get the URL."
  echo "e.g. https://app.testfairy.com/projects/16629-mytestapp/builds/3345302/sessions"
  echo "     app      16629-mytestapp"
  echo "     builds   3345302"
  echo
}

function download() {
  app=$1
  build=$2
  sessionId=$3
  cookieValue='Cookie: q=1498425981; fs_uid=fullstory.com`2136V`6398380880166912:5629499534213120`53902`; oribi_user_guid=fdf09b44-ca3a-9fbb-53d6-c187c3e11fbb; _ga=GA1.2.2012864859.1498425954; intercom-lou-y7zoicwn=1; G_ENABLED_IDPS=google; l=NTM5MDItMTUyMDYwMjU2OC1kYmZjNzc3ZWNjYjgwYzc1MjUwZjkzNDFmZGQ0ZWRiMzNkY2MyNDUy; _gid=GA1.2.174398859.1521208227; _gat=1; intercom-session-y7zoicwn=eG1lOENTbjdkUkxZdmZpUFROWXBlVW92amV4eWV0YlgwMk5Bd0VOaVJjNVJVS3JKejhOWXJtTEl1OWR4QTZWKy0tWkRBeFp2TkNVckFyZUJaWnVZRldwQT09--afed5585a4d987e3f0898904f5a599fdcbd27773'
  curl "https://app.testfairy.com/projects/$app/builds/$build/sessions/$sessionId/save-logcat" -H "$cookieValue" > "session-${sessionId}.log";
}

#
# Main
#
app=$1
build=$2
lastSessionId=$3
startSessionId=$4

if [ -z "$app" ]; then
  echo
  echo "ERROR: Missing APP parameter"
  print_help
  exit
fi

if [ -z "$build" ]; then
  echo
  echo "ERROR: Missing BUILD parameter"
  print_help
  exit
fi

if [ -z "$lastSessionId" ]; then
  echo
  echo "ERROR: Missing lastSessionId parameter"
  print_help
  exit
fi

if [ -z "$startSessionId" ]; then
  startSessionId=1
fi

for ((I=$lastSessionId; I>=$startSessionId; I--))
do
	download "$app" "$build" $I
done
