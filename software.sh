#!/bin/bash

# Fix permissions on /usr/local/
sudo chflags norestricted /usr/local && sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local

#
# Check if Homebrew is installed
#
which -s brew
if [[ $? != 0 ]] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

brew tap homebrew/dupes
brew tap homebrew/versions

#
# Check if Git is installed
#
which -s git || brew install git

apps=(
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

brews=(
  ack
  bash
  bash-completion2
  bfg
  binutils
  binwalk
  boost
  colordiff
  coreutils
  dex2jar
  dns2tcp
  findutils
  foremost
  freetype
  gcc
  gettext
  git
  git-lfs
  gmp
  gnu-sed
  gpg
  grep
  highlight
  icu4c
  isl
  jasper
  jpeg
  knock
  libdnet
  libidn
  libmpc
  libogg
  libpng
  libtiff
  libtool
  lua
  lynx
  mcrypt
  mhash
  moreutils
  mpfr
  mysql
  narwhal
  netpbm
  nmap
  openssh
  openssl
  p7zip
  pcre
  php56
  php56-mcrypt
  pigz
  pkg-config
  pngcheck
  pv
  pyside
  qt
  readline
  rename
  rhino
  ringojs
  screen
  sfnt2woff
  sfnt2woff-zopfli
  shiboken
  socat
  speedtest_cli
  sqlite
  tcptrace
  tmux
  tree
  ucspi-tcp
  unixodbc
  vbindiff
  vim --with-lu --override-system-vi
  webkit2png
  webp
  wget --enable-iri
  woff2
  xz
  zopfli
)


# Remove packages from brews list that are already installed
for (( i=0; i < ${#brews[@]}; i++ )); do
    brew ls | grep ${brews[i]}
    if [[ $? != 0 ]] ; then
        brews=( "${brews[@]:0:$i}" "${brews[@]:$((i + 1))}" )
    fi
done

# Install apps to /Applications rather than ~/Applications
printf "\n%s\n" "installing ${brews[@]}.."
brew install ${brews[@]}


# Remove packages from apps list that are already installed
for (( i=0; i < ${#apps[@]}; i++ )); do
    brew cask ls | grep ${apps[i]}
    if [[ $? != 0 ]] ; then
        apps=( "${apps[@]:0:$i}" "${apps[@]:$((i + 1))}" )
    fi
done

# Install apps to /Applications rather than ~/Applications
printf "\n%s\n" "installing ${apps[@]}.."
brew cask install --appdir="/Applications" ${apps[@]}

brew ls
brew cask ls

brew upgrade
brew cleanup
