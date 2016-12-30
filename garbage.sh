#!/bin/bash

# clean system of unnecessary built-in apps
sudo rm -rf /Applications/GarageBand.app
sudo rm -rf /Applications/iMovie.app
sudo rm -rf /Applications/iTunes.app
sudo rm -rf "/Library/Application Support/GarageBand"
sudo rm -rf "/Library/Application Support/Logic"
sudo rm -rf "/Library/Audio/Apple Loops"

echo "Removing fonts from /System/Library/Fonts/.."
cat lists/systemlibraryfonts | while read line; do
  echo "..${line}"
  rm -rf /System/Library/Fonts/$line
done

echo "Removing fonts from /Library/Fonts/.."
cat lists/libraryfonts | while read line; do
  echo "..${line}"
  rm -rf /Library/Fonts/$line
done



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
