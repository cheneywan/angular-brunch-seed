#!/bin/sh

lastHash=`git log $1 -1 --pretty=format:"%H"`
if [ $? -eq 0 ]; then
  echo "$lastHash";
else
  echo "";
fi

