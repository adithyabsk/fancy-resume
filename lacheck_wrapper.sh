#!/bin/sh
if [ $# -ne 1 ]; then
  echo 1>&2 "Usage: ./lacheck_wrapper.sh [FILENAME]"
  exit 3
fi
# BODY=$(lacheck "$1")
BODY=$(lacheck "$1" 2>&1 | grep -v '\*\*');
if [ -n "$BODY" ]
   then
   echo "$BODY"
   exit 1
else
  exit 0
fi