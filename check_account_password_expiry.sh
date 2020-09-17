#!/bin/bash
# Check Password expiry on Linux
# Keith Rogers - 13/Feb/2014 (Version 1.1)

function check_usage {
	if (( $# != 1 ))
	then
        	echo "Usage: ./check_expiry.sh <username>"
        exit 3
	fi
}

function calculate_days_till_expiry {
	get_expiry_date=$(sudo chage -l bk | grep 'Password expires' | cut -d: -f2)
	if [[ $get_expiry_date = 'Never' ]]
	then
		echo "Password never expires"
	exit 0
	elif
	password_expiry_date=`date -d "$get_expiry_date" "+%s"`
	#echo "Expiring - $password_expiry_date"
	#echo  $password_expiry_date
	current_date=$(date "+%s")
	#echo "Current - $current_date"
	exp=`expr $password_expiry_date - $current_date`
	#echo $exp
	DAYS=`expr \( $exp / 86400 \)`
	#echo $DAYS
	then
	if (($DAYS>=15 && $DAYS<=90))
	then
        	echo "OK - Password is $DAYS days from expiry"
	exit 0
	elif (($DAYS>=5 && $DAYS<=14))
	then
        	echo "WARNING - Password is $DAYS days from expiry"
	exit 1
	elif (($DAYS>=0 && $DAYS<=4))
	then
	        echo "CRITICAL - Password is $DAYS days from expiry"
	exit 2
	fi
fi
}

#check_usage
calculate_days_till_expiry
