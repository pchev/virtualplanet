#!/bin/bash

mkdir Viking
mkdir Viking/L1
mkdir Viking/L2
mkdir Viking/L3
mkdir Viking/L4
mkdir Viking/L5

for f in $(find Viking_Color -name *.jpg); do 
  echo convert $f -fx intensity -depth 8 ${f/Viking_Color/Viking} 
  convert $f -fx intensity -depth 8 ${f/Viking_Color/Viking} 
done
