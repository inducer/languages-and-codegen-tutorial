#! /bin/bash

set -e
set -x

TUT_ID=dsl

URL=http://andreask.cs.illinois.edu/tmp/$TUT_ID-tutorial-materials-dist.zip
cp tut-pack.run tut-pack-custom.run
sed -i s,MY_TUT_ID,$TUT_ID, tut-pack-custom.run
sed -i s,MYURL,$URL, tut-pack-custom.run
TGT=tiker.net:public_html/tmp

rsync -rav --delete ../dist $TGT/$TUT_ID-tutorial-materials
rsync -rav tut-pack-custom.run $TGT/$TUT_ID-tut-pack.run
rsync -rav ../$TUT_ID-tutorial-materials-dist.zip $TGT

URL=http://relate.cs.illinois.edu/dl/$TUT_ID/$TUT_ID-tutorial-materials-dist.zip
cp tut-pack.run tut-pack-custom.run
sed -i s,MY_TUT_ID,$TUT_ID, tut-pack-custom.run
sed -i s,MYURL,$URL, tut-pack-custom.run
TGT=class@rl:dl/$TUT_ID-tutorial

rsync -rav --delete ../dist $TGT/materials
rsync -rav tut-pack-custom.run $TGT/$TUT_ID-tut-pack.run
rsync -rav ../$TUT_ID-tutorial-materials-dist.zip $TGT
ssh class@rl "chmod a+rX dl -R"

rm tut-pack-custom.run

echo "COMPLETED"
