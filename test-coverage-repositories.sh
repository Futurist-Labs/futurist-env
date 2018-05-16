#!/bin/bash

function sectionHeader() {
  echo
  echo
  echo
  echo "# $1"
  echo "==========================================================="
}

egrep -lir --include=*Repository.java "public interface" ./src/main/ | xargs grep '(' | sed -E 's|.*/(.*)\.java.* (.*)\(.*|\1::\2|' | sort | uniq > repos.tmp
find ./src/test/ -name '*RepositoryTest.java' | xargs grep -A 1 'Test' | grep  "public" | grep -v "public class " | sed -E 's|.*/([^/]*)Test.java.*void ([^_\(]*).*|\1::\2|' | sort | uniq > tests.tmp

sectionHeader "COVERED"
comm -12 repos.tmp tests.tmp

sectionHeader "TEST WITH WRONG NAMES"
comm -13 repos.tmp tests.tmp

sectionHeader "NOT COVERED"
comm -23 repos.tmp tests.tmp

sectionHeader "STATS"
echo "# REPOSITORY METHODS: " `cat repos.tmp | wc -l `
echo "# COVERED: " `comm -12 repos.tmp tests.tmp | wc -l`
echo "# TEST WITH WRONG NAMES: " `comm -13 repos.tmp tests.tmp | wc -l`
echo "# NOT COVERED: " `comm -23 repos.tmp tests.tmp | wc -l`
echo

rm repos.tmp
rm tests.tmp
