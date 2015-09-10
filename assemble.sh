#! /bin/zsh

set -e
set -x
setopt -o EXTENDED_GLOB

mkdir -p dist

ME=$(readlink -f "$0")
DIR=$(dirname "$ME")
MYDIR=$(cd "$DIR" && pwd)

for nb in [0-9]*/**/*ipynb; do
  echo "PROCESSING $nb"
  DIR="$(dirname "$nb")"
  TRUNK="$(basename "$nb")"
  TRUNK="${TRUNK%.ipynb}"

  CONV_DIR="dist/$DIR"
  mkdir -p "$CONV_DIR"
  CONV_BASE="dist/${nb%.ipynb}"
  CONV_PY="${CONV_BASE}.py"
  CONV_HTML="${CONV_BASE}.html"

  PROCESSED_IPYNB="${CONV_BASE}.ipynb"
  "$MYDIR/ipython-demo-tools/demo-ready-ipynb" --keep "$nb" "$PROCESSED_IPYNB"
  # if ! test -f "$CONV_PY" || test "$nb" -nt "$CONV_PY"; then
  #   ipython nbconvert "$PROCESSED_IPYNB" --to=python "--output=${CONV_BASE}"
  # fi
  # if ! test -f "$CONV_HTML" || test "$nb" -nt "$CONV_HTML"; then
  #   ipython nbconvert "$PROCESSED_IPYNB" --to=html "--output=${CONV_BASE}"
  # fi
  if ! test -f "$CONV_PDF" || test "$nb" -nt "$CONV_PDF"; then
    ipython nbconvert "$PROCESSED_IPYNB" --to=latex --post=PDF "--output=${CONV_BASE}"

    mv "${TRUNK}.pdf" $CONV_DIR
    rm -f "${CONV_BASE}.tex"
    rm -Rf "${CONV_BASE}_files"
    rm -f "${TRUNK}.log" "${TRUNK}.out" "${TRUNK}.aux"
  fi
done
function mkdir_and_cp()
{
  dn=$(dirname "$2")
  mkdir -p "$dn"
  cp "$1" "$2"

}

for i in [0-9]*/**/*~*ipynb~*.pyc~*\~(#q.)(#qN); do
  mkdir_and_cp $i dist/$i
done
for i in slides/out/[0-9]*pdf; do
  bn=$(basename "$i")
  mkdir_and_cp $i dist/${bn%.pdf}/0-slides.pdf
done
