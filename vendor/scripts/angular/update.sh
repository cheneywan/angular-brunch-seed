#!/bin/sh

version="1.1.5"
localeFolder="i18n"
host="http://code.angularjs.org"

downfile () {
  echo "start update $1"
  rm -rf $1
  wget -O $1 "$host/$version/$1"
}

for file in "cookies" "loader" "resource" "sanitize"; do
  filename="angular-$file.js"
  downfile $filename
done

for filename in "angular.js" "version.json"; do
  downfile $filename
done

for locale in "zh"; do
  filename="$localeFolder/angular-locale_$locale.js"
  rm -rf $localeFolder
  mkdir $localeFolder
  downfile $filename
done
