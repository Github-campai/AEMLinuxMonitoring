# AEM Linux Monitor

AEM Linux Monitor is a simple-to-use monitoring script which runs completely out of AEM (Datto RMM).
This script determines if the distrobution you're using is Debian or Red Hat Enterprise Linux

## Installation

Create a custom device monitor and paste the contents of monitor.sh in the "Script" field with the script language selected on "Unix(Linux, Mac OSX)"

## Testing and debugging

This script can be clones to a device locally and be run as stand-alone script
For example:

```bash
bash ~/monitoring.sh updates
```
This will check the current amount of package updates available and give you an output of the response which would be send to AEM

## Current possible commands

```bash
bash ~/monitoring.sh updates #(10 updates available)
bash ~/monitoring.sh swap #(check if swap is enabled, if not, return exit code 1. If enabled, show current free swap)
bash ~/monitoring.sh tcpsockets #(check amount of tcpsockets in use overall)
bash ~/monitoring.sh zombie #(check amount of zombie processes)
bash ~/monitoring.sh process #(check total amount of processes running)
bash ~/monitoring.sh load5min #(show the average load in the last 5 minutes)
bash ~/monitoring.sh mysqlslave #(work in progress, but show the amount of connected slaves to the master)
bash ~/monitoring.sh SERVICE:* #(show of the specified service is running, or not. If not, return exit code 1. Example: bash ~/monitoring.sh SERVICE:apache2)
bash ~/monitoring.sh GLUSTER:* #(show the requested data of a GlusterFS volume. Example: bash ~/monitoring.sh GLUSTER:split:gvol0 #Check if there are any split-brain files existing on volume gvol0 at this host)
bash ~/monitoring.sh REDIS:ROLE #(show the status of every redis-server running on the machine. Slave of Master)
bash ~/monitoring.sh REDIS:SERVERS #(count how many servers there are running on the server. return error code 1 or 0 depending on the setting defined)
```

## Example:

```bash
root@test:~# bash monitor.sh SERVICE:apache2
<-Start Result->
I= apache2 is active
<-End Result->
root@test:~#
```


## Important note!

This script can still contain errors and is not guaranteed to work correctly as it should. The branch you're in is currently 'dev'.
This script is currently not in the stable branch due to the dirty if statements and dirty code



## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.