#! /bin/zsh

set -e
setopt -o EXTENDED_GLOB

unset PYTHONWARNINGS

TUT_ID=dsl

PDF_OUTPUT=0
HTML_OUTPUT=1

mkdir -p dist
rm -Rf cleared

ME=$(readlink -f "$0")
DIR=$(dirname "$ME")
MYDIR=$(cd "$DIR" && pwd)

function with_echo()
{
  echo "$@"
  "$@"
}

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
  CONV_PDF="${CONV_BASE}.pdf"

  PROCESSED_IPYNB="${CONV_BASE}.ipynb"
  "$MYDIR/ipython-demo-tools/prepare-ipynb" remove-marks "$nb" "$PROCESSED_IPYNB"
  # if ! test -f "$CONV_PY" || test "$nb" -nt "$CONV_PY"; then
  #   jupyter-nnbconvert "$PROCESSED_IPYNB" --to=python "--output=${CONV_BASE}"
  # fi
  if [[ "$HTML_OUTPUT" = "1" ]]  && (! test -f "$CONV_HTML" || test "$nb" -nt "$CONV_HTML"); then
    with_echo python $(which jupyter-nbconvert) "$PROCESSED_IPYNB" --to=html
  fi
  if [[ "$PDF_OUTPUT" = "1" ]] && (! test -f "$CONV_PDF" || test "$nb" -nt "$CONV_PDF"); then
    with_echo python $(which jupyter-nbconvert) "$PROCESSED_IPYNB" --to=pdf
  fi

  CONV_DIR="cleared/$DIR"
  with_echo mkdir -p "$CONV_DIR"
  CONV_IPYNB="cleared/$nb"
  with_echo "$MYDIR/ipython-demo-tools/prepare-ipynb" clear-output clear-marked-inputs "$nb" "$CONV_IPYNB"
done
function mkdir_and_cp()
{
  dn=$(dirname "$2")
  with_echo mkdir -p "$dn"
  with_echo cp "$1" "$2"

}

for i in [0-9]*/**/*~*ipynb~*.pyc~*\~(#q.)(#qN); do
  mkdir_and_cp $i dist/$i
  mkdir_and_cp $i cleared/$i
done
for i in slides/out/[0-9]*pdf; do
  bn=$(basename "$i")
  mkdir_and_cp $i dist/${bn%.pdf}/0-slides.pdf
done

with_echo cp -R --reflink dist $TUT_ID-tutorial-materials
with_echo cp -R --reflink cleared $TUT_ID-tutorial-materials
with_echo rm -f $TUT_ID-tutorial-materials-dist.zip
with_echo zip -r $TUT_ID-tutorial-materials-dist.zip $TUT_ID-tutorial-materials
with_echo rm -Rf $TUT_ID-tutorial-materials

