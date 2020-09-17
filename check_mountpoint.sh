#!/bin/bash

mp=$(mountpoint /bikya)
if [ "$mp" == "/bikya is a mountpoint" ];
then
echo "OK - Bikya Mounted"
exit 0
else
echo "CRITICAL - Bikya is not Mounted"
exit 2
fi

