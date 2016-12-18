#!/bin/bash

# Update system and setup command-line tools
xcode-select --install

# Update system Ruby
#sudo /usr/bin/gem update --system --no-document

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
brew tap homebrew/homebrew-php
brew tap caskroom/fonts
brew tap caskroom/versions


# Check if Git is installed/Users/davidcondrey/Github/init/software/brews
which -s git || brew install git

#
# set fish as default shell
# echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
# chsh -s $(brew --prefix)/bin/fish
# mkdir -p ~/.config/fish

function loopinstaller () {
	local l;
	local a;
	local f;

	case "$1" in
        brew)
            l="Homebrew packages"
            ;;
         
        cask)
            l="software applications"
            ;;
         
        gem)
            l="Ruby Gems"
            ;;
        npm)
            l="npm modules"
            a="-g"
            ;;
        *)
            exit 1
 
	esac

	read -p "Do you want to modify or review which $list will be installled?" confirm
	
	if [[ $confirm =~ [yY](es)* ]]; then
		"${EDITOR:-vi}" lists/$1s
	fi;

	echo "Installing $(echo $list | tr '[:upper:]' '[:lower:]' | awk '{print $NF}').."
	cat lists/$1s | while read l; do
  		echo "..${line}"
  
  		if [[ "$1" -eq "gem" ]]; then
  			brew gem install $line
  			[ ! -f "$($? -ne 0)" ] && f+=($l)
		else
			$1 install $a $l
			[ ! -f "$($? -ne 0)" ] && f+=($l)
		fi
	done

	if [ -n "$f" ]; then
		echo "These items failed to be properly installed: "
		echo "$f"
	fi	
}

loopinstall cask
loopinstall brew
loopinstall gem
loopinstall npm

# Install easy_install
[ ! -f "$(which easy_install)" ] && curl https://bootstrap.pypa.io/ez_setup.py -o - | sudo python

sudo easy_install pip

# Update Python package manager
pip install --upgrade pip

curl -O  http://pear.php.net/go-pear.phar
php -d detect_unicode=0 go-pear.phar

phpversion="$(php -v | tail -r | tail -n 1 | cut -d " " -f 2 | cut -c 1-3)"
echo -e "\ninclude_path = '.:/Users/davidcondrey/pear/share/pear/' \nextension=v8js.so \n" >> /usr/local/etc/php/$(phpversion)/php.ini

git clone https://github.com/phpv8/v8js $TMPDIR/v8js && cd $_
./configure CXXFLAGS="-Wno-c++11-narrowing"
make
make test
make install

sudo apachectl restart

# Fix permissions on /usr/local/
sudo chflags norestricted /usr/local && sudo chown "$(whoami)":admin /usr/local && sudo chown -R "$(whoami)":admin /usr/local

sudo chown -R "$(whoami)" "$(npm config get prefix)"/{lib/node_modules,bin,share}

brew cask update
brew cask cleanup
brew upgrade
brew cleanup
brew doctor
