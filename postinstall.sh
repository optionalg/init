#!/bin/sh
mas signin $PRIMARY_EMAIL

sudo chflags -R nouchg,nouappnd ~ $TMPDIR.. ;
sudo chown -R $UID:staff ~ $_ ;
sudo chmod -R -N ~ $_ ;
sudo chmod -R 755 ~ $_ ;
sudo chmod 700 Desktop Documents Downloads Dropbox Library Movies Music Pictures Sites $_ ;
sudo chmod 777 Public ;
sudo chmod 733 Public/Drop\ Box ;
} 2> /dev/null

dscacheutil -flushcache;

(
sudo chown root:admin /
sudo kextcache -system-prelinked-kernel
sudo kextcache -system-caches
sudo chmod -R -N /Volumes
)


unset installed
unset ascii2hex
unset _echo