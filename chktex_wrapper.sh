#!/bin/sh
if [ $# -ne 1 ]; then
  echo 1>&2 "Usage: ./chktex_wrapper.sh [FILENAME]"
  exit 3
fi
BODY=$(
    output="$(chktex -q -V "$1" 2>&1 | grep -v 'chktex: WARNING --')";
    warn=$(echo $output | grep Warning);
    if [ "$warn" ] ;
        then echo "$output" ;
    fi
)
if [ -n "$BODY" ]
   then
   echo "$BODY"
   exit 1
else
  exit 0
fi