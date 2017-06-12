#!/bin/bash

function print_help() {
  echo
  echo "Usage: $0 app build last-session-id"
  echo "  app             - app id (the value after /project/)"
  echo "  build           - build id (the value after /builds/)"
  echo "  last-session-id - the largest session number for this build"
  echo "  help            - print this help"
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
  curl "https://app.testfairy.com/projects/$app/builds/$build/sessions/$sessionId/save-logcat" -H 'Cookie: SpryMedia_DataTables_latest-sessions_5302334=%7B%22iCreate%22%3A1491939624535%2C%22iStart%22%3A60%2C%22iEnd%22%3A70%2C%22iLength%22%3A10%2C%22aaSorting%22%3A%5B%5B0%2C%22desc%22%5D%5D%2C%22oSearch%22%3A%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%2C%22aoSearchCols%22%3A%5B%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%2C%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%2C%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%2C%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%2C%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%2C%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%2C%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%2C%7B%22bCaseInsensitive%22%3Atrue%2C%22sSearch%22%3A%22%22%2C%22bRegex%22%3Afalse%2C%22bSmart%22%3Atrue%7D%5D%2C%22abVisCols%22%3A%5Btrue%2Ctrue%2Ctrue%2Ctrue%2Ctrue%2Ctrue%2Ctrue%2Ctrue%5D%7D; q=1487668970; fs_uid=www.fullstory.com`2136V`5159532518965248:5665117697998848`53902`; l=NTM5MDItMTQ5MTkyMDcwOC0zOTRjODU2NWJiYjI1NDcwZTEzYmQwYTYzZWE4NGY2Y2QwZGYxMzAy; oribi_user_guid=346594cf-27e6-4667-24d6-ad315d048656; G_ENABLED_IDPS=google; _ga=GA1.2.2116701706.1487668966; intercom-session-y7zoicwn=c3JyU2pvVCswMWxyK2VyTGcrektnYXFGWjcvMkxFTEdTY3I5ejJKWDJ6N0g2eW5UdDVQK25HdHRSQk1WaWEzcy0tcGMwN2wrdFAzSzZxVXVPWnV0M2Nsdz09--8cb53677446fdaa800c81575058b6f04f12ddd24' > "session-${sessionId}.log";
}

#
# Main
#
app=$1
build=$2
lastSessionId=$3

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

for ((I=1; I<=$lastSessionId; I++))
do
	download "$app" "$build" $I
done
