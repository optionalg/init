#!/bin/bash
find /var/db/com.apple.xpc.launchd/ -type f -print -exec defaults read {} \; 2>/dev/null


mv /System/Library/LaunchAgents/com.apple.AOSPushRelay.plist /System/Library/LaunchAgents/disabled/com.apple.AOSPushRelay.plist
# tests reachability of www.apple.com # tests reachability of www.apple.com
mv /System/Library/LaunchAgents/com.apple.ManagedClient.agent.plist /System/Library/LaunchAgents/disabled/com.apple.ManagedClient.agent.plist
mv /System/Library/LaunchAgents/com.apple.ManagedClient.enrollagent.plist /System/Library/LaunchAgents/disabled/com.apple.ManagedClient.enrollagent.plist
mv /System/Library/LaunchAgents/com.apple.Maps.pushdaemon.plist /System/Library/LaunchAgents/disabled/com.apple.Maps.pushdaemon.plist
mv /System/Library/LaunchAgents/com.apple.aos.migrate.plist /System/Library/LaunchAgents/disabled/com.apple.aos.migrate.plist
mv /System/Library/LaunchAgents/com.apple.apsctl.plist /System/Library/LaunchAgents/disabled/com.apple.apsctl.plist
mv /System/Library/LaunchAgents/com.apple.gamed.plist /System/Library/LaunchAgents/disabled/com.apple.gamed.plist
mv /System/Library/LaunchAgents/com.apple.mdmclient.agent.plist /System/Library/LaunchAgents/disabled/com.apple.mdmclient.agent.plist
mv /System/Library/LaunchAgents/com.apple.mdmclient.cloudconfig.agent.plist /System/Library/LaunchAgents/disabled/com.apple.mdmclient.cloudconfig.agent.plist
mv /System/Library/LaunchAgents/com.apple.safaridavclient.plist /System/Library/LaunchAgents/disabled/com.apple.safaridavclient.plist
mv /System/Library/LaunchAgents/com.apple.sbd.plist /System/Library/LaunchAgents/disabled/com.apple.sbd.plist
mv /System/Library/LaunchAgents/com.apple.sharingd.plist /System/Library/LaunchAgents/disabled/com.apple.sharingd.plist
mv /System/Library/LaunchAgents/com.apple.ubd.plist /System/Library/LaunchAgents/disabled/com.apple.ubd.plist
mv /System/Library/LaunchDaemons/com.apple.apsd.plist /System/Library/LaunchDaemons/disabled/com.apple.apsd.plist
mv /System/Library/LaunchDaemons/com.apple.ManagedClient.cloudconfigurationd.plist /System/Library/LaunchDaemons/disabled/com.apple.ManagedClient.cloudconfigurationd.plist
mv /System/Library/LaunchDaemons/com.apple.ManagedClient.enroll.plist /System/Library/LaunchDaemons/disabled/com.apple.ManagedClient.enroll.plist
mv /System/Library/LaunchDaemons/com.apple.ManagedClient.plist /System/Library/LaunchDaemons/disabled/com.apple.ManagedClient.plist
mv /System/Library/LaunchDaemons/com.apple.ManagedClient.startup.plist /System/Library/LaunchDaemons/disabled/com.apple.ManagedClient.startup.plist
mv /System/Library/LaunchDaemons/com.apple.awacsd.plist /System/Library/LaunchDaemons/disabled/com.apple.awacsd.plist
mv /System/Library/LaunchDaemons/com.apple.familycontrols.plist /System/Library/LaunchDaemons/disabled/com.apple.familycontrols.plist
mv /System/Library/LaunchDaemons/com.apple.findmymac.plist /System/Library/LaunchDaemons/disabled/com.apple.findmymac.plist
mv /System/Library/LaunchDaemons/com.apple.iCloudStats.plist /System/Library/LaunchDaemons/disabled/com.apple.iCloudStats.plist
mv /System/Library/LaunchDaemons/com.apple.laterscheduler.plist /System/Library/LaunchDaemons/disabled/com.apple.laterscheduler.plist
mv /System/Library/LaunchDaemons/com.apple.mbicloudsetupd.plist /System/Library/LaunchDaemons/disabled/com.apple.mbicloudsetupd.plist
mv /System/Library/LaunchDaemons/com.apple.mdmclient.daemon.plist /System/Library/LaunchDaemons/disabled/com.apple.mdmclient.daemon.plist
mv /System/Library/LaunchDaemons/com.apple.msrpc.echosvc.plist /System/Library/LaunchDaemons/disabled/com.apple.msrpc.echosvc.plist
mv /System/Library/LaunchDaemons/com.apple.msrpc.lsarpc.plist /System/Library/LaunchDaemons/disabled/com.apple.msrpc.lsarpc.plist
mv /System/Library/LaunchDaemons/com.apple.msrpc.mdssvc.plist /System/Library/LaunchDaemons/disabled/com.apple.msrpc.mdssvc.plist
mv /System/Library/LaunchDaemons/com.apple.msrpc.netlogon.plist /System/Library/LaunchDaemons/disabled/com.apple.msrpc.netlogon.plist
mv /System/Library/LaunchDaemons/com.apple.msrpc.srvsvc.plist /System/Library/LaunchDaemons/disabled/com.apple.msrpc.srvsvc.plist
mv /System/Library/LaunchDaemons/com.apple.msrpc.wkssvc.plist /System/Library/LaunchDaemons/disabled/com.apple.msrpc.wkssvc.plist
# will listen to ports 137, 138 even if turned off in Sharing PrefPane # will listen to ports 137, 138 even if turned off in Sharing PrefPane
mv /System/Library/LaunchDaemons/com.apple.netbiosd.plist /System/Library/LaunchDaemons/disabled/com.apple.netbiosd.plist
mv /System/Library/LaunchDaemons/com.apple.rpmuxd.plist /System/Library/LaunchDaemons/disabled/com.apple.rpmuxd.plist
mv /System/Library/LaunchDaemons/com.apple.security.FDERecoveryAgent.plist /System/Library/LaunchDaemons/disabled/com.apple.security.FDERecoveryAgent.plist
# this one is getting on my nerves # this one is getting on my nerves
mv /System/Library/LaunchAgents/com.apple.TMHelperAgent.SetupOffer.plist /System/Library/LaunchAgents/disabled/com.apple.TMHelperAgent.SetupOffer.plist
mv /System/Library/UserEventPlugins/BTMMPortInUseAgent.plugin /System/Library/UserEventPlugins/disabled/BTMMPortInUseAgent.plugin
mv /System/Library/UserEventPlugins/CaptiveSystemAgent.plugin /System/Library/UserEventPlugins/disabled/CaptiveSystemAgent.plugin
mv /System/Library/UserEventPlugins/CaptiveUserAgent.plugin /System/Library/UserEventPlugins/disabled/CaptiveUserAgent.plugin
mv /System/Library/UserEventPlugins/EAPOLMonitor.plugin /System/Library/UserEventPlugins/disabled/EAPOLMonitor.plugin
mv /System/Library/UserEventPlugins/com.apple.reachability.plugin /System/Library/UserEventPlugins/disabled/com.apple.reachability.plugin
# new with 10.9.3 # new with 10.9.3
mv /System/Library/LaunchAgents/com.apple.appleseed.seedusaged.plist /System/Library/LaunchAgents/disabled/com.apple.appleseed.seedusaged.plist
mv /System/Library/LaunchDaemons/com.apple.appleseed.fbahelperd.plistmv  /System/Library/LaunchDaemons/disabled/com.apple.appleseed.fbahelperd.plistmv 






launchctl unload -w /System/Library/LaunchDaemons/ftp.plist
launchctl unload -w /System/Library/LaunchDaemons/tftp.plist
launchctl remove -w /System/Library/LaunchDaemons/finger.plist
launchctl remove -w /System/Library/LaunchDaemons/telnet.plist

launchctl unload -w /System/Library/LaunchDaemons/org.openldap.slapd.plist

# Portmap
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.portmap.plist


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
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponderHelper.plist

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