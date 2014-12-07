#!/bin/bash
#
# move .bash_profile and .bashrc into place
mv *.bash* ~/
mv .css ~/

# xcode command-line tools
xcode-select --install

# homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# wget
curl http://ftp.gnu.org/gnu/wget/wget-1.15.tar.xz > wget-1.15.tar.xz &&
tar -xzf wget-1.15.tar.xz && cd wget-1.15 && ./configure --with-ssl=openssl && make -j8 && sudo make install &&
cd .. && rm -rf wget*

# setup git
git config --global user.name "davidcondrey"
git config --global user.email "davidcondrey@me.com"
git config --global color.ui auto
## git extras
(cd /tmp && git clone --depth 1 https://github.com/tj/git-extras.git && cd git-extras && sudo make install)

# set textmate as default for git
git config --global core.editor "mate -w"
## textmate bundles
BUNDLES_PATH=`pwd`
mkdir -p ~/Library/Application\ Support/TextMate/Bundles
rm -rf ~/Library/Application\ Support/TextMate/Bundles
mkdir -p Bundles
ln -sf "$BUNDLES_PATH/Bundles" ~/Library/Application\ Support/TextMate/Bundles
get_bundle() {
  (
  if [ -d "$3" ]; then
    echo "Updating $1's $2"
    cd "$3"
    git pull --rebase
  else
    git clone "git://github.com/$1/$2.git" "$3"
  fi
  )
}
get_bundle drnic github-tmbundle "Bundles/github.tmbundle"
get_bundle fgnass jshint.tmbundle "Bundles/jshint.tmbundle"
get_bundle grorg/svg-tmbundle.git "Bundles/svg.tmbundle
get_bundle jcf git-tmbundle "Bundles/git.tmbundle"
get_bundle kswedberg jquery-tmbundle "Bundles/jquery.tmbundle"
get_bundle kuroir SCSS.tmbundle "Bundles/scss.tmbundle"
get_bundle outofcontrol Blade.tmbundle "Bundles/blade.tmbundle"
get_bundle Shopify liquid-tmbundle "Bundles/liquid.tmbundle"
get_bundle textmate json.tmbundle "Bundles/json.tmbundle"
get_bundle textmate markdown.tmbundle "Bundles/markdown.tmbundle"
get_bundle textmate mediawiki.tmbundle "Bundles/mediawiki.tmbundle"
get_bundle textmate textile.tmbundle "Bundles/textile.tmbundle"
get_bundle vigo textmate-twitterbootstrap.tmbundle "Bundles/twitterbootstrap.tmbundle"
sudo ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/local/bin
osascript -e 'tell app "TextMate" to reload bundles'
echo "Textmate setup complete"
