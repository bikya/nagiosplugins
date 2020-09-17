#!/bin/sh

if [ "$1" = "-w" ] && [ "$2" -gt "0" ] && [ "$3" = "-c" ] && [ "$4" -gt "0" ]
then
warn=$2
crit=$4
idle=$(iostat | awk 'FNR==4{print $6}' | cut -c 1,2)
if [ $warn -gt $idle ]
then
	if [ $crit -gt $idle ]
	then
		echo "CRITICAL - CPU=$idle %"
		exit 2
	else
		echo "WARNING - CPU=$idle %"
		exit 1
	fi
else
echo "OK - CPU=$idle %"
exit 0
fi
else
exit 3
fi
