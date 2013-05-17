#!/bin/sh

git fetch

filePwd=$(dirname "$0")
branchName=`git rev-parse --abbrev-ref HEAD`
remoteHash=$($filePwd/get_branch_hash.sh "origin/$branchName")
localHash=$($filePwd/get_branch_hash.sh "$branchName")

echo "remote "$branchName" last hash: "$remoteHash
echo "local "$branchName" last hash: "$localHash

if [ $remoteHash ]; then
  if [ $remoteHash != $localHash ]; then
    exit 1
  else
    exit 0
  fi
else
  exit 0
fi

