#!/bin/bash

# Copy repository configuration folders into user home directory
tools=$(ls config)

for tool in $tools; do
  cp -rf "config/$tool" "$HOME/.config"
done

