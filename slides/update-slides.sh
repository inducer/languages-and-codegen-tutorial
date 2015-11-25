#! /bin/sh

set -e
set -x

for i in 01 03 06; do
  tgt_dir=$(echo ../$i*)
  cp out/$i-*.pdf  $tgt_dir/0-slides.pdf
done
