#!/bin/bash

export MAGICK_MEMORY_LIMIT=3000000000
export MAGICK_MAP_LIMIT=2000000000
export MAGICK_AREA_LIMIT=2000000000

convert mercury_20130514_complete_mono_basemap_1000mpp_equirectangular.png -resize 20000x10000 merL3.jpg
convert merL3.jpg -resize 10000x5000 merL2.jpg
convert merL2.jpg -resize 4000x2000 merL1.jpg

echo L1
mkdir ../L1
convert merL1.jpg +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% ../L1/%d.jpg

echo L2
mkdir ../L2
convert merL2.jpg +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% ../L2/%d.jpg
convert merL2.jpg +gravity -crop 10000x1000 R%d.png
convert R0.png -resize 3000x1000\!  RS0.jpg
convert R4.png -resize 3000x1000\!  RS4.jpg
convert RS0.jpg +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% ../L2/1000%d.jpg
convert RS4.jpg +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% ../L2/2000%d.jpg
rm R[0-4].png RS[0-4].jpg

echo L3
mkdir ../L3
convert merL3.jpg +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% ../L3/%d.jpg
convert merL3.jpg +gravity -crop 20000x1000 R%d.png
convert R0.png -resize 3000x1000\!  RS0.jpg
convert R9.png -resize 3000x1000\!  RS9.jpg
convert RS0.jpg +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% ../L3/1000%d.jpg
convert RS9.jpg +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% ../L3/2000%d.jpg
rm R[0-9].png RS[0-9].jpg

