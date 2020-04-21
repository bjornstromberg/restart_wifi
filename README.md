This script is intended to mitigate the issues with a bug in the 2.4GHz driver 
  on TP-Link Archer C7 v2.0 using OpenWRT (until bug is fixed..)

NOTE: it will need clients on both interfaces to not invoke a restart!

for those who need it..

to use wifi restart:
* login to router via ssh
* copy contents of 'check_wifi_restart.sh' to '/bin/check_wifi_restart.sh' on router.
  * /bin is safe on restarts, so it will survive a restart on the overlay partition.
* install nano if you need a easier editor then vi and does not yet have it installed..
  * run 'opkg update && opkg install nano'
* edit cron with nano 
  * run 'EDITOR=nano crontab -e'
  * add '*/15 * * * * /bin/check_wifi_restart.sh >> /tmp/log/restart_wifi.log'
    * /tmp is cleard on router restarts, 
    this way the log wont fill up the overlay partition, and we get some info how often the issue arises..
    Note: it will restart wifi alot if nobody is home, and not both interfaces are in use..
  * save and close
* enable cron
  * run '/etc/init.d/cron enable'
  * run '/etc/init.d/cron start'
* when wifi is restarted due to no clients on a interface it will print a line in '/tmp/log/restart_wifi.log'
