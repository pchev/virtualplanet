#!/bin/bash

rm -rf share
mkdir -p share/virtualplanet/Overlay
cp -a Callisto  Europa  Ganymede  Io  Mars  Mercury Venus share/virtualplanet/Overlay/
tar czf VPA_Base_Overlay.tgz share
