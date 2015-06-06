#!/bin/bash

apps=(
  appcleaner
  betterzipql
  cyberduck
  dropbox
  firefox
  github
  google-chrome
  iterm2
  java
  nvalt
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  rescuetime
  sequel-pro
  shiori
  skype
  slack
  sophos-anti-virus-home-edition
  sublime-text3
  transmission
  transmit
  vagrant
  virtualbox
  vlc
  webpquicklook
)

# Install apps to /Applications rather than ~/Applications
echo "installing applications.."
brew cask install --appdir="/Applications" ${apps[@]}
