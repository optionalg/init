#!/bin/sh

# move .bash_profile and .bashrc into place
mv *.bash* ~/ && mv .css ~/
mv "Sublime Text 3" ~/Library/Application\ Support/
export HISTSIZE=2000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT=
export PROMPT_COMMAND='history -a'
shopt -s cmdhist
shopt -s histappend

# xcode command-line tools
(
xcode-select --install;
sleep 1;
osascript -e \
    'tell application "System Events" \\
        tell process "Install Command Line Developer Tools" \\
            keystroke return \\
            click button "Agree" of window "License Agreement"'
)

{ sudo chflags -R nouchg,nouappnd ~ $TMPDIR.. ; \
sudo chown -R $UID:staff ~ $_ ; \
sudo chmod -R -N ~ $_ ; \
sudo chmod -R 755 ~ $_ ; \
sudo chmod 700 Desktop Documents Downloads Dropbox Library Movies Music Pictures Sites $_ ; \
sudo chmod 777 Public ; \
sudo chmod 733 Public/Drop\ Box ; \
} 2> /dev/null

sh software.sh


# Set the colours you can use
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

# Resets the style
reset=`tput sgr0`

# Color-echo. Improved. [Thanks @joaocunha]
# arg $1 = message
# arg $2 = Color
cecho() {
  echo "${2}${1}${reset}"
  return
}

# Set continue to false by default
CONTINUE=false


# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Would you like to set your computer name (as done via System Preferences >> Sharing)? "
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo "What would you like it to be?"
  read COMPUTER_NAME
  sudo scutil --set ComputerName $COMPUTER_NAME
  sudo scutil --set HostName $COMPUTER_NAME
  sudo scutil --set LocalHostName $COMPUTER_NAME
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
fi

echo "Hide the Time Machine, Volume, User, and Bluetooth icons? "
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
  defaults write "${domain}" dontAutoLoad -array \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu"
done

defaults write com.apple.systemuiserver menuExtras -array \
  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
  "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  "/System/Library/CoreServices/Menu Extras/Clock.menu"

echo "Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed before"
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

echo "Change indexing order and disable some search results in Spotlight"
defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "PDF";}' \
    '{"enabled" = 1;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}' \
    '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}' \
    '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
  # Load new settings before rebuilding the index
  killall mds > /dev/null 2>&1
  # Make sure indexing is enabled for the main volume
  sudo mdutil -i on / > /dev/null
  # Rebuild the index from scratch
  sudo mdutil -E / > /dev/null

echo "Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
echo "Displaying ASCII control characters using caret notation in standard text views"
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

echo "Save to disk, rather than iCloud, by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

echo "Disable smart quotes and smart dashes"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "Disable Photos.app from starting everytime a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


###############################################################################
# General Power and Performance modifications
###############################################################################

echo "Disable hibernation"
sudo pmset -a hibernatemode 0

echo "Remove the sleep image file to save disk space"
echo "(If you're on a <128GB SSD, this helps but can have adverse affects on performance. You've been warned.)"
sudo rm /Private/var/vm/sleepimage
echo "Creating a zero-byte file instead"
sudo touch /Private/var/vm/sleepimage
echo "and make sure it can't be rewritten"
sudo chflags uchg /Private/var/vm/sleepimage

echo "Disable the sudden motion sensor? (it's not useful for SSDs/current MacBooks)"
sudo pmset -a sms 0

echo "Disable system-wide resume"
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

echo "Disable the menubar transparency"
defaults write com.apple.universalaccess reduceTransparency -bool true

echo "Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

echo "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo "Enabling full keyboard access for all controls (enable Tab in modal dialogs, menu windows, etc.)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Disabling press-and-hold for special keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "Setting a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo "Disable display from automatically adjusting brightness)"
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

defaults write com.apple.screencapture type -string "jpg"

echo "Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "Enabling HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################

echo "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo "Show hidden files in Finder by default"
defaults write com.apple.Finder AppleShowAllFiles -bool true

echo "Show dotfiles in Finder by default"
defaults write com.apple.finder AppleShowAllFiles TRUE

echo "Show all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Show status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Disable the warning when changing a file extension?"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Use column view in all Finder windows by default?"
defaults write com.apple.finder FXPreferredViewStyle Clmv

echo "Avoid creation of .DS_Store files on network volumes?"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Disable disk image verification?"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "Show item info near icons on the desktop and in other icon views?"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

echo "Show item info to the right of the icons on the desktop?"
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

echo "Enable snap-to-grid for icons on the desktop and in other icon views?"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo "Increase grid spacing for icons on the desktop and in other icon views?"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

echo "Increase the size of icons on the desktop and in other icon views?"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist


echo "Wipe all (default) app icons from the Dock?"
echo "(This is only really useful when setting up a new Mac, or if you don't use the Dock to launch apps.)"
defaults write com.apple.dock persistent-apps -array

echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

echo "Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

defaults write com.apple.finder DisableAllAnimations -bool true

echo "Disable the over-the-top focus ring animation"
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

echo "Privacy: Don't send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "Hiding Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "Disabling Safari's thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "Making Safari's search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo "Removing useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "Disabling the annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

echo "Using the system-native print preview dialog in Chrome"
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

echo "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"


###############################################################################
# Time Machine
###############################################################################

echo "Prevent Time Machine from prompting to use new hard drives as backup volume?"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "Disable local Time Machine backups? (This can take up a ton of SSD space on <128GB SSDs)"
hash tmutil &> /dev/null && sudo tmutil disablelocal


echo "Disable automatic emoji substitution in Messages.app? (i.e. use plain text smileys)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

echo "Disable smart quotes in Messages.app? (it's annoying for messages that contain code)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo "Disable continuous spell checking in Messages.app?"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

echo "Do you use Transmission for torrenting?"
mkdir -p ~/Downloads/Incomplete

echo "Setting up an incomplete downloads folder in Downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"

echo "Setting auto-add folder to be Downloads"
defaults write org.m0k.transmission AutoImportDirectory -string "${HOME}/Downloads"

echo "Don't prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false

echo "Trash original torrent files after adding them"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

echo "Hiding the donate message"
defaults write org.m0k.transmission WarningDonate -bool false

echo "Hiding the legal disclaimer"
defaults write org.m0k.transmission WarningLegal -bool false

echo "Auto-resizing the window to fit transfers"
defaults write org.m0k.transmission AutoSize -bool true

echo "Auto updating to betas"
defaults write org.m0k.transmission AutoUpdateBeta -bool true

echo "Setting up the best block list"
defaults write org.m0k.transmission EncryptionRequire -bool true
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"


git config --global core.editor "subl -n -w"
git config --global alias.lastchange 'log -p --follow -n 1'
git config --global user.name "davidcondrey"
git config --global user.email "davidcondrey@me.com"
git config --global color.ui auto

launchctl unload -w  /System/Library/LaunchDaemons/com.apple.spindump.plist
launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.spindump
launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.spindump_symbolicator
launchctl unload -w /System/Library/LaunchDaemons/com.apple.spindump_agent
launchctl unload -w /System/Library/LaunchAgents/com.apple.gamed.plist
launchctl unload -w  /System/Library/LaunchAgents/com.apple.AirPortBaseStationAgent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.VoiceOver.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.voiceinstallerd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.synthesisserver.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.recognitionserver.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.feedbackservicesserver.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.speechdatainstallerd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.RemoteDesktop.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.midiserver.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.java.updateSharing.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.java.InstallOnDemand.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.familycontrols.useragent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudfamilyrestrictionsd-mac.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.familycircled.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.familycontrols.useragent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.familynotificationd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.xmigrationhelper.user.plist
launchctl unload -w /System/Library/LaunchDaemons/com.apple.CoreRAID
launchctl unload -w /System/Library/LaunchDaemons/com.apple.Kerberos.digest-service
launchctl unload -w /System/Library/LaunchDaemons/com.apple.Kerberos.kadmind
launchctl unload -w /System/Library/LaunchDaemons/com.apple.Kerberos.kcm
launchctl unload -w /System/Library/LaunchDaemons/com.apple.Kerberos.kdc
launchctl unload -w /System/Library/LaunchDaemons/com.apple.Kerberos.kpasswdd
launchctl unload -w /System/Library/LaunchDaemons/com.apple.ManagedClient.cloudconfigurationd
launchctl unload -w /System/Library/LaunchDaemons/com.apple.ManagedClient.enroll
launchctl unload -w /System/Library/LaunchDaemons/com.apple.ManagedClient
launchctl unload -w /System/Library/LaunchDaemons/com.apple.ManagedClient.startup
launchctl unload -w /System/Library/LaunchDaemons/com.apple.NetBootClientStatus
launchctl unload -w /System/Library/LaunchDaemons/com.apple.NetworkDiagnostics
launchctl unload -w /System/Library/LaunchDaemons/com.apple.NetworkLinkConditioner
launchctl unload -w /System/Library/LaunchDaemons/com.apple.RemoteDesktop.PrivilegeProxy
launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root
launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportPanicService
launchctl unload -w /System/Library/LaunchDaemons/com.apple.ServerPerfLog.aslmanager
launchctl unload -w /System/Library/LaunchDaemons/com.apple.ServerPerfLog
launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo
launchctl unload -w /System/Library/LaunchDaemons/com.apple.airport.wps
launchctl unload -w /System/Library/LaunchDaemons/com.apple.airportPrefsUpdater
launchctl unload -w /System/Library/LaunchDaemons/com.apple.airportd
launchctl unload -w /System/Library/LaunchDaemons/com.apple.efax
launchctl unload -w /System/Library/LaunchAgents/com.apple.parentalcontrols.check.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.ScreenReaderUIServer.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.safaridavclient.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.KerberosHelper.LKDCHelper
launchctl unload -w /System/Library/LaunchAgents/com.apple.ManagedClient.agent
launchctl unload -w /System/Library/LaunchAgents/com.apple.ManagedClient.enrollagent

launchctl unload -w /System/Library/LaunchAgents/com.apple.NetworkDiagnostics
launchctl unload -w /System/Library/LaunchAgents/com.apple.PCIESlotCheck
launchctl unload -w /System/Library/LaunchAgents/com.apple.RemoteDesktop
launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportCrash.Self
launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportCrash
launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportGPURestart
launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportPanic
launchctl unload -w /System/Library/LaunchAgents/com.apple.ScreenReaderUIServer
launchctl unload -w /System/Library/LaunchAgents/com.apple.SubmitDiagInfo
launchctl unload -w /System/Library/LaunchAgents/com.apple.VoiceOver
launchctl unload -w /System/Library/LaunchAgents/com.apple.gamed
launchctl unload -w /System/Library/LaunchAgents/com.apple.midiserver
launchctl unload -w /System/Library/LaunchAgents/com.apple.parentalcontrols.check
launchctl unload -w /System/Library/LaunchAgents/com.apple.safaridavclient
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.feedbackservicesserver
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.recognitionserver
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.speechdatainstallerd
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.speechsynthesisd
launchctl unload -w /System/Library/LaunchAgents/com.apple.speech.synthesisserver
launchctl unload -w /System/Library/LaunchAgents/com.apple.spindump_agent
chmod 755 /System/Library/CoreServices/Dock.app/Contents/XPCServices/com.apple.dock.extra.xpc
chmod 755 /Applications/iTunes.app/Contents/MacOS/iTunesHelper.app
chmod 755 /System/Library/PrivateFrameworks/BookKit.framework/XPCServices/com.apple.BKAgentService.xpc

cecho "Done!" $cyan
cecho "################################################################################" $white
cecho "Note that some of these changes require a logout/restart to take effect." $red
cecho "Killing some open applications in order to take effect." $red

find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Terminal" "Transmission"; do
  killall "${app}" > /dev/null 2>&1
done
