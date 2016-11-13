#!/bin/bash
## Disable DVD or CD Sharing.
service com.apple.ODSAgent stop
## Disable Screen Sharing.
sudo rm /Library/Preferences/com.apple.ScreenSharing.launchd
## Disable FTP.
launchctl unload -w /System/Library/LaunchDaemons/ftp.plist

## Disable SMB.
defaults delete /Library/Preferences/SystemConfiguration/com.apple.smb.server EnabledServices
launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist
launchctl unload -w /System/Library/LaunchDaemons/nmbd.plist
launchctl unload -w /System/Library/LaunchDaemons/smbd.plist
## Disable AFP.
launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist

# Disable NFS
nfsd disable
rm /etc/export

## Disable Web Sharing service.
launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist
## Disable Remote Login.
service ssh stop
## Disable Remote Management.
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop
rm -rf /var/db/RemoteManagement ; \
defaults delete /Library/Preferences/com.apple.RemoteDesktop.plist ; \
defaults delete ~/Library/Preferences/com.apple.RemoteDesktop.plist ; \
rm -r /Library/Application\ Support/Apple/Remote\ Desktop/ ; \
rm -r ~/Library/Application\ Support/Remote\ Desktop/ ; \
rm -r ~/Library/Containers/com.apple.RemoteDesktop

# disable remote apple events
systemsetup -setremoteappleevents off
launchctl unload -w /System/Library/LaunchDaemons/eppc.plist

## Disable Xgrid Sharing.
xgridctl controller stop
xgridctl agent stop

## Disable Internet Sharing.
defaults write /Library/Preferences/SystemConfiguration/com.apple.nat NAT -
dict Enabled -int 0
launchctl unload -w /System/Library/LaunchDaemons/
com.apple.InternetSharing.plist

## Disable Bluetooth Sharing.
defaults -currentHost write com.apple.bluetooth PrefKeyServicesEnabled 0
defaults write /Library/Preferences/com.apple.Bluetooth \
ControllerPowerState -int 0
killall -HUP blued

# disable infrared sensor
defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -int 0

# disable bonjour
defaults write /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist ProgramArguments -array-add "-NoMulticastAdvertisements"


# disable remote login
systemsetup -setremotelogin off


# enable firewall
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

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