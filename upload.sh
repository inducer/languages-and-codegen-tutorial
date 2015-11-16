#! /bin/bash

set -e
set -x

TGT=tiker.net:public_html/tmp
rsync -rav dist $TGT/sc15-tutorial-materials
rsync -rav sc15-pack.run $TGT
rsync -rav sc15-tutorial-materials-dist.zip $TGT

TGT=class@rl:dl/sc15-tutorial
rsync -rav dist $TGT/materials
rsync -rav sc15-pack.run $TGT
rsync -rav sc15-tutorial-materials-dist.zip $TGT
ssh class@rl "chmod a+rX dl -R"

echo "COMPLETED"
