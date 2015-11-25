#! /bin/sh

set -e
set -x

for i in 01 03 06; do
  cp out/$i-*.pdf  ../$i*
done
