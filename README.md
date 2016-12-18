# MacOS Developer Initialization

Setup a new Mac for web development, mindful of system optimization and security.

Written for my own usage; but should work well for anybody.  Opinionated but adaptive.

## setup.sh

Application entry point.

```
chmod u+x setup.sh && ./setup.sh
```

## software.sh

 - Install Command-line Tools
 - Install Homebrew (an opportunity to review and modify each list becomes available immediately before its read)
   - cli: `list/brews`
   - software: `list/casks`
   - ruby: `list/gems`
   - npm: `list/npms`
 - Update everything
 - Cleanup

 ## clean.sh

  - Remove all non-required fonts installed by the OS
  - Remove some garbage ware installed by the OS

## cron.sh

 - Setup some default cronjobs

 ## harden.sh

 - Remove unnecessary launchagents/daemons and services.
 - Set recommended OSX security settings

 ## todo

 - Test and verify software.sh
 - Move launchagents/daemons/services to lists arrays
 - Finish harden.sh




