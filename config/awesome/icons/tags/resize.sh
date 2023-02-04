#!/bin/bash

if [ -z "$1" ]
    then
        echo "No folder is given"
else
    for file in $1/*; do 
        echo "$file"
        convert $file -resize 64x64 $file
        convert $file -rotate 270 $file
    done
fi