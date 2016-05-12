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
  adium
  appcleaner
  betterzipql
  cyberduck
  dropbox
  firefox
  github
  google-chrome
  imageoptim
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
  coreutils
  binutils
  diffutils
  gawk
  wget --enable-iri
  bash
  bash-completion2
  fish
  grep
  ed --default-names
  findutils --with-default-names
  gnu-getopt --with-default-names
  gnu-indent --with-default-names
  gnu-tar --with-default-names
  gnu-sed --with-default-names
  gnutls --with-default-names
  python --with-brewed-openssl
  openssh --with-brewed-openssl
  vim --with-lu --override-system-vi
  macvim --HEAD --with-cscope --with-lua --with-override-system-vim --with-luajit --with-python
  ack
  bfg
  binwalk
  boost
  closure-compiler
  colordiff
  dex2jar
  dns2tcp
  foremost
  freetype
  gcc
  gettext
  gist
  git-lfs
  gmp
  gpg
  highlight
  icu4c
  imagemagick
  imagesnap
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
  maven
  mcrypt
  mhash
  moreutils
  mpfr
  mysql
  narwhal
  netpbm
  nmap
  openssl
  p7zip
  pcre
  php56
  php56-mcrypt
  pigz
  pkg-config
  pngcheck
  potrace
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
  terminal-notifier
  tmux
  tree
  ucspi-tcp
  unixodbc
  v8
  vbindiff
  webkit2png
  webp
  woff2
  xz
  zopfli
  zsh
)

npm=(
  bower
  csslint
  eslint
  express
  glob
  grunt
  grunt-cli
  handlebars
  jscs
  jshint
  lodash
  matchdep
  nodemon
  yo
)

# Remove packages from brews list that are already installed
for (( i=0; i < ${#brews[@]}; i++ )); do
    brew ls | grep ${brews[i]}
    if [[ $? != 0 ]] ; then
        brews=( "${brews[@]:0:$i}" "${brews[@]:$((i + 1))}" )
    fi
done

brew link curl --force
sudo echo $(brew --prefix)/bin/bash >> /etc/shells && \
chsh -s $(brew --prefix)/bin/bash

# set fish as default shell
echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
chsh -s $(brew --prefix)/bin/fish
mkdir -p ~/.config/fish

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


$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

# install node
curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" && sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"

# Ensure NODE_PATH is set
grep NODE_PATH ~/.bash_profile > /dev/null || cat "export NODE_PATH=/usr/local/lib/node_modules" >> ~/.bash_profile && . ~/.bash_profile
grep MANPATH ~/.bash_profile > /dev/null || cat "export $MANPATH=$(brew --prefix coreutils)/libexec/gnuman:$MANPATH" >> ~/.bash_profile && . ~/.bash_profile

echo "installing npm packages.."
for n in "${npm[@]}"; do:
  echo "..${n}"
  npm install -g ${n}
done
