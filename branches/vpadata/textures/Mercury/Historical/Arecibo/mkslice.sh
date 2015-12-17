#!/bin/bash

export MAGICK_MEMORY_LIMIT=3000000000
export MAGICK_MAP_LIMIT=2000000000
export MAGICK_AREA_LIMIT=2000000000

echo L1
mkdir L1
convert arecibo_L1.jpg +gravity -crop 1000x1000 -bordercolor white -border 12x12 -quality 65% L1/%d.jpg
