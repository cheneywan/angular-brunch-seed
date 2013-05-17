#!/bin/sh

lessModule="../../../submodule/bootstrap/less"

rm -rf `ls -l1 | grep \.less`

for file in `ls -l1 $lessModule | grep \.less`; do
  ln -s $lessModule/$file
  mv $file _$file
done
