#!/bin/sh

jsModule="../../../submodule/bootstrap/js"

rm -rf `ls -l1 | grep \.js`

for file in `ls -l1 $jsModule | grep \.js`; do
  ln -s $jsModule/$file
  mv $file $file
done
