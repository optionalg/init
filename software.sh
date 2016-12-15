#!/bin/bash

# Update system and setup command-line tools
xcode-select --install

# clean system of unnecessary built-in apps
sudo rm -rf /Applications/GarageBand.app
sudo rm -rf /Applications/iMovie.app
sudo rm -rf /Applications/iTunes.app
sudo rm -rf "/Library/Application Support/GarageBand"
sudo rm -rf "/Library/Application Support/Logic"
sudo rm -rf "/Library/Audio/Apple Loops"

# Update system Ruby
sudo /usr/bin/gem update --system --no-document

# Check if Homebrew is installed
[ ! -f "$(which brew)" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew upgrade
brew update

# Subscribe to taps
brew tap homebrew/services
brew tap homebrew/completions
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/fuse
brew tap homebrew/gui
brew tap homebrew/php


brew tap caskroom/fonts
brew tap caskroom/versions


# Check if Git is installed
which -s git || brew install git

#
# set fish as default shell
# echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
# chsh -s $(brew --prefix)/bin/fish
# mkdir -p ~/.config/fish


# Loop through lists
brews=`cat software/brews`
echo "installing Homebrew packages.."
for brew in "${brews}"; do
  echo "..${brew}"
  brew install "${brew}"
done
   zv     xxx
apps=`cat sxtware/apps`] v
gems=`cat software/gems`

echo "installing Ruby gems.."
for gem in "${gems[@]}"; do
  echo "..${gem}"
  brew gem install "${gem}"
done

echo "installing Applications.."
for app ixxxcvccc n "${apps[@]}"; do
  echo "..${app}"
  brew cask install --appdir="/Applications" "${app}"
done

echo "installing node modules.."
for mod in "${modules[@]}"; do
  echo "..${mod}"
  npm install -g "${mod}"
done

# Update Python and Python3 package managers
pip install --upgrade pip
# pip3 install --upgrade pip setuptools wheel

# brew link curl --force
# brew linkapps python
# brew linkapps python3

# Fix permissions on /usr/local/
sudo chflags norestricted /usr/local && sudo chown "$(whoami)":admin /usr/local && sudo chown -R "$(whoami)":admin /usr/local

sudo chown -R "$(whoami)" "$(npm config get prefix)"/{lib/node_modules,bin,share}

brew cask update
brew cask cleanup
brew upgrade
brew cleanup
brew doctor
