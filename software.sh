#!/bin/bash

# Remove junk applications
rm -rf /Applications/GarageBand.app
rm -rf /Applications/iMovie.app
rm -rf /Applications/iTunes.app
rm -rf "/Library/Application Support/GarageBand"
rm -rf "/Library/Application Support/Logic"
rm -rf "/Library/Audio/Apple Loops"

# Check if Homebrew is installed
which -s brew
if [[ $? != 0 ]] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# Subscribe to taps
brew tap homebrew/services
brew tap homebrew/completions
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/fuse
brew tap homebrew/gui

brew tap caskroom/fonts
brew tap caskroom/versions

brew tap macvim-dev/macvim

# Check if Git is installed
which -s git || brew install git

sudo /usr/bin/gem update --system

apps=(
    '1password'
    'adium'
    'alfred'
    'appcleaner'
    'avira-antivirus'
    'avira-vpn'
    'betterzipql'
    'docker-toolbox'
    'dropbox'
    'electron'
    'epubquicklook'
    'firefox-beta'
    'flux'
    'font-anonymous-pro'
    'font-dejavu-sans-mono-for-powerline'
    'font-droid-sans'
    'font-droid-sans-mono'
    'font-inconsolata'
    'font-input'
    'font-liberation-sans'
    'font-nixie-one'
    'font-pt-mono'
    'font-roboto'
    'font-source-code-pro'
    'font-source-sans-pro'
    'google-chrome-canary'
    'google-drive'
    'gpgtools'
    'imageoptim'
    'iterm2-beta'
    'java'
    'jumpcut'
    'monolingual'
    'nvalt'
    'odrive'
    'osxfuse-beta'
    'qlcolorcode'
    'qlimagesize'
    'qlmarkdown'
    'qlprettypatch'
    'qlstephen'
    'quicklook-csv'
    'quicklook-json'
    'shortcat'
    'slack-beta'
    'sublime-text-dev'
    'transmission-nightly'
    'transmit'
    'vagrant'
    'virtualbox'
    'vlc'
    'webpquicklook'
)

brews=(
    'aircrack-ng'
    'autoconf'
    'automake'
    'bash'
    'bash-completion2'
    'binutils'
    'binwalk'
    'brew-gem'
    'closure-compiler'
    'colordiff'
    'coreutils'
    'dex2jar'
    'diffutils'
    'dns2tcp'
    'doxygen'
    'findutils --with-default-names'
    'fish'
    'foremost'
    'freetype'
    'gem-completion'
    'gettext'
    'gist'
    'git'
    'git-extras'
    'git-utils'
    'grep'
    'htop'
    'imagemagick --with-librsvg'
    'imagesnap'
    'lynx'
    'maven'
    'mcrypt'
    'meld'
    'mysql'
    'nmap --HEAD --with-pygtk'
    'openssh --with-brewed-openssl'
    'openssl'
    'pcre'
    'php56'
    'php56-mcrypt'
    'pigz'
    'pkg-config'
    'pngcheck'
    'potrace'
    'pv'
    'python --HEAD'
    'python3 --HEAD'
    'readline'
    'sfnt2woff'
    'sfnt2woff-zopfli'
    'socat'
    'speedtest_cli'
    'sqlite --with-json1'
    'tcptrace'
    'terminal-notifier'
    'tmux'
    'tree'
    'v8'
    'vbindiff'
    'webkit2png'
    'webp --HEAD --with-libtiff'
    'wget --enable-iri'
    'woff2'
    'xz'
    'zopfli'
)

gems=(
    'bundler'
    'compass'
    'jsdoc'
    'nokogiri'
    'sass'
)

modules=(
    'bower'
    'csslint'
    'electron'
    'eslint'
    'express'
    'glob'
    'grunt'
    'grunt-cli'
    'gulp-cli'
    'handlebars'
    'jscs'
    'jshint'
    'less'
    'lodash'
    'matchdep'
    'nodemon'
    'react'
    'underscore'
    'yo'
)

brew install --HEAD macvim-dev/macvim/macvim --HEAD --with-lua --with-luajit --with-override-system-vim --with-python3

sudo echo $(brew --prefix)/bin/bash >> /etc/shells && \
chsh -s $(brew --prefix)/bin/bash

# set fish as default shell
echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
chsh -s $(brew --prefix)/bin/fish
mkdir -p ~/.config/fish

# Install Node
curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" && sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"

# Ensure NODE_PATH is set
grep NODE_PATH ~/.bash_profile > /dev/null || cat "export NODE_PATH=/usr/local/lib/node_modules" >> ~/.bash_profile && . ~/.bash_profile
grep MANPATH ~/.bash_profile > /dev/null || cat "export $MANPATH=$(brew --prefix coreutils)/libexec/gnuman:$MANPATH" >> ~/.bash_profile && . ~/.bash_profile

# Install apps to /Applications rather than ~/Applications
echo "installing Homebrew packages.."
for brew in "${brews[@]}"; do:
  echo "..${brew}"
  brew install ${brew}
done

echo "installing Ruby gems.."
for gem in "${gems[@]}"; do:
  echo "..${gem}"
  brew gem install ${gem}
done

echo "installing Applications.."
for app in "${apps[@]}"; do:
  echo "..${apps}"
  brew cask install --appdir="/Applications" ${apps}
done

echo "installing node modules.."
for mod in "${modules[@]}"; do:
  echo "..${mod}"
  npm install -g ${mod}
done

pip install --upgrade pip
pip3 install --upgrade pip setuptools wheel

brew link curl --force
brew linkapps macvim
brew linkapps python
brew linkapps python3



# Fix permissions on /usr/local/
sudo chflags norestricted /usr/local && sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local

brew cask update
brew cask cleanup
brew upgrade
brew cleanup
brew doctor


