#!/bin/bash

# Declare files to extract
folders=("awesome" "kitty")
from_path="${HOME}/.config/"
to_path="config"

for folder in ${folders[*]}; do
  folder_path="${from_path}${folder}"
  echo "Exctracting $folder"
  cp -rf $folder_path $to_path
done

echo "Exctraction complete"
