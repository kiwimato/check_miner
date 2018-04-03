This is just a service that will check if the miner is down based on api stats.

Be sure to copy the *.service files in and reload systemctl daemons afterwards :
``` /etc/systemd/system/check_miner.service
/etc/systemd/system/multi-user.target.wants/check_miner.service

```
