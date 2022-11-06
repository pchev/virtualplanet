#!/bin/bash
#
     
rm -rf share
mkdir -p share/virtualplanet/Textures/Callisto/Historical

ls -d * | grep -v mkhist | grep -v share | while read d 
  do
    echo $d
    cd $d
    convert $d.jpg -resize 4000x2000 l1.png
    mkdir -p ../share/virtualplanet/Textures/Callisto/Historical/$d/L1
    convert l1.png +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% ../share/virtualplanet/Textures/Callisto/Historical/$d/L1/%d.jpg
    rm l1.png
    cd ..
  done

tar cvzf VPA_Base_Texture_Callisto_Historical.tgz share

  
  