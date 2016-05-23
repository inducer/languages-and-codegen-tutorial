#! /bin/bash

set -e
set -x

TUT_ID=dsl
URL=https://andreask.cs.illinois.edu/tutorial/$TUT_ID-tutorial-materials-dist.zip
GITHUB_URL=https://github.com/inducer/languages-and-codegen-tutorial
TGT=tiker.net:public_html/tutorial

sed s,GITHUB_URL,$GITHUB_URL, index.md | \
  sed s,BROWSE_PATH,$TUT_ID-tutorial-materials/dist/, | \
  sed s,ZIP_NAME,$TUT_ID-tutorial-materials-dist.zip, | \
  pandoc -t html - > index.html
rsync -rav index.html $TGT/
rm index.html

cp tut-pack.run tut-pack-custom.run
sed -i s,MY_TUT_ID,$TUT_ID, tut-pack-custom.run
sed -i s,MYURL,$URL, tut-pack-custom.run
rsync -rav tut-pack-custom.run $TGT/tut-pack.run
rm tut-pack-custom.run

rsync -rav --progress ../$TUT_ID-tutorial-materials-dist.zip $TGT
rsync -rav --progress --delete ../dist $TGT/$TUT_ID-tutorial-materials


echo "COMPLETED"
