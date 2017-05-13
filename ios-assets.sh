#!/bin/bash

function print_help() {
  echo
  echo "Usage: $0 list|stats"
  echo "  list [all] - list all or unused assets"
  echo "  stats      - print assets stats"
  echo "  help       - print this help"
  echo
}

function listAssetCatalogs() {
  grep "folder.assetcatalog" "${projfolder}/project.pbxproj" | sed -e "s/.*folder.assetcatalog; path = \(.*\); sourceTree.*/${codefolder}\/\1/"
}

function listAssetsForCatalogs() {
  xargs ls | sed -e "s/\(.*\).imageset/\1/" | grep -v 'AppIcon.appiconset' | grep -v ".json"
}

function listUsageCount() {
  codefolder=$1
  asset=$2
  echo "$asset usages:"`grep -R "$asset" ${codefolder}/ --exclude-dir "Assets.xcassets" | wc -l `
}
export -f listUsageCount

function filterUsed() {
  grep 'usages: 0'
}

function listAllAssets() {
  listAssetCatalogs | listAssetsForCatalogs | xargs -I {} bash -c "listUsageCount $codefolder {}"
}


#
# Operations
#
function opListAssets() {
  if [ "$applyFilter" == "1" ]; then
    listAllAssets | filterUsed
  else
    listAllAssets
  fi
}

function opStats() {
  echo "Assets size: "
  listAssetCatalogs | xargs -I {} bash -c "du -d 0 -h {}"
  echo
  echo "Unused assets: `listAllAssets | filterUsed | wc -l`"
}

#
# Check parameters
#
operation=$1

echo `pwd`
projfolder=`ls | grep .xcodeproj`
codefolder=`echo ${projfolder} | sed -e "s/\(.*\).xcodeproj/\1/"`

if [ "${operation}" == "list" ]; then
  if [ "$2" == "all" ]; then
    applyFilter=0
  else
    applyFilter=1
  fi
  opListAssets
elif [ "${operation}" == "stats" ]; then
  opStats applyFilter
else
  print_help
fi
