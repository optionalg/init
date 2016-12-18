#!/bin/bash

# clean system of unnecessary built-in apps
sudo rm -rf /Applications/GarageBand.app
sudo rm -rf /Applications/iMovie.app
sudo rm -rf /Applications/iTunes.app
sudo rm -rf "/Library/Application Support/GarageBand"
sudo rm -rf "/Library/Application Support/Logic"
sudo rm -rf "/Library/Audio/Apple Loops"

echo "Removing fonts from /System/Library/Fonts/.."
cat lists/systemlibraryfonts | while read line; do
  echo "..${line}"
  rm -rf /System/Library/Fonts/$line
done

echo "Removing fonts from /Library/Fonts/.."
cat lists/libraryfonts | while read line; do
  echo "..${line}"
  rm -rf /Library/Fonts/$line
done

