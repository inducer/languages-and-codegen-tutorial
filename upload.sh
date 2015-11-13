#! /bin/bash

rsync -rav dist tiker.net:public_html/tmp/sc15-tutorial-materials
rsync -rav sc15-pack.run tiker.net:public_html/tmp/
rsync -rav sc15-tutorial-materials-dist.zip tiker.net:public_html/tmp/
