 
#!/bin/bash

img=$1
rot=1024

convert $img -resize 2048x1024 tmp.png
convert tmp.png -roll +$rot+0 rot_$img
rm tmp.png