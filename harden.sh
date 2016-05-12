#!/bin/bash
rm -rf /var/db/RemoteManagement ; \
defaults delete /Library/Preferences/com.apple.RemoteDesktop.plist ; \
defaults delete ~/Library/Preferences/com.apple.RemoteDesktop.plist ; \
rm -r /Library/Application\ Support/Apple/Remote\ Desktop/ ; \
rm -r ~/Library/Application\ Support/Remote\ Desktop/ ; \
rm -r ~/Library/Containers/com.apple.RemoteDesktop

# disable infrared sensor
defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -int 0

# disable bluetooth
defaults write /Library/Preferences/com.apple.Bluetooth \
ControllerPowerState -int 0
killall -HUP blued

# disable bonjour
defaults write /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist ProgramArguments -array-add "-NoMulticastAdvertisements"
# disable remote apple events
systemsetup -setremoteappleevents off

# disable remote login
systemsetup -setremotelogin off

# disable file sharing
launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist
launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist

# enable firewall
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# stop ftp server
-s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist
# stop nfs server
nfsd disable
rm /etc/export

# screensaver immediate lock
defaults write com.apple.screensaver askForPasswordDelay -int 0
# screensaver password
defaults write com.apple.screensaver askForPassword -int 1

systemsetup -setcomputersleep Never # disable sleep

systemsetup -setrestartfreeze on # auto restart on freeze

# renew dhcp
ipconfig set en0 DHCP

# clear dns cache
dscacheutil -flushcache && \
killall -HUP mDNSResponder

# list all hardware ports
networksetup -listallhardwareports
# connected devices uuid
system_profiler SPUSBDataType | sed -n -e '/iPad/,/Serial/p' -e '/iPhone/,/Serial/p'
# screen resolution
system_profiler SPDisplaysDataType | grep Resolution
# cpu brand string
sysctl -n machdep.cpu.brand_string
# show dhcp info
ipconfig getpacket en0