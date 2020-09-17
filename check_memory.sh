#!/bin/sh

if [ "$1" = "-w" ] && [ "$2" -gt "0" ] && [ "$3" = "-c" ] && [ "$4" -gt "0" ]
then
warn=$2
crit=$4
free=$(df -h / | awk 'FNR==2{print $5}' | cut -c 1,2)
if [ $warn -gt $free ]
then
	if [ $crit -gt $free ]
	then
		echo "CRITICAL - MEM=$free %"
		exit 2
	else
		echo "WARNING - MEM=$free %"
		exit 1
	fi
else
echo "OK - MEM=$free %"
exit 0
fi
else
exit 3
fi
