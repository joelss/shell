#!/bin/bash
#set -x
# the script to monitor my VPS
# It will alert when memory, load, CPU%, networking, httpd/mysqld or home-page 
#    is in an abnormal state.
# author: Jay
# date: 2013-10-16

EMAIL="yongjie.ren@dianping.com"
WARN_MSG=""

# alert when free memory is less than 50 MB
function mem_free()
{
	threshold=50  # 50 MB free memory
	free_mem=$(free -m | grep "buffers/cache" | awk '{print $4}')
	if [ $free_mem -lt $threshold ]; then
		WARN_MSG=$WARN_MSG"Free memeory is less than $threshold MB.\n"
		return 1
	fi
	return 0
}

# alert when load (5min) is larger than 4
function load_avg()
{
	threshold=4  # load is 4
	load_5min=$(cat /proc/loadavg | awk '{print $2}')
	if [ $(echo "$load_5min > $threshold" | bc) -eq 1 ]; then
        	WARN_MSG=$WARN_MSG"5min average load is larger than $threshold.\n"
		return 1
	fi
	return 0
}

# alert when CPU idle% is less than 20%
function cpu_idle()
{
	threshold=20  # CPU idle% 20%
	cpu_idle=$(sar 1 5 | grep -i 'Average' | awk '{print $NF}')
	if [ $(echo "$cpu_idle < $threshold" | bc) -eq 1 ]; then
		# in printf cmd, %% represents a single % 
		WARN_MSG=$WARN_MSG"CPU idle%% is less than $threshold%%.\n"
		return 1
	fi
	return 0
}

# alert when networking tx speed is larger than 80 kB/s
function network_tx()
{
	threshold=80  # TX speed 80 kB/s
	interface=eth0
	tx_speed=$(sar -n DEV 10 5 | grep "Average" | grep "$interface" | awk '{print $6}')
	if [ $(echo "$tx_speed > $threshold" | bc) -eq 1 ]; then
		WARN_MSG=$WARN_MSG"networking TX speed is larger than $threshold kB/s.\n"
		return 1
	fi
	return 0
}

# alert when httpd or mysqld process doesn't exist
function httpd_mysqld()
{
	ps -ef | grep 'httpd' | grep -v 'grep'
	if [ $? -ne 0 ]; then
		WARN_MSG=$WARN_MSG"httpd process doesn't exist.\n"
		return 1
	else
		ps -ef | grep 'mysqld' | grep -v 'grep'
		if [ $? -ne 0 ]; then
			WARN_MSG=$WARN_MSG"mysqld process doesn't exist.\n"
			return  1
		fi
	fi
	return 0
}

# alert when 'Stay hungry' doesn't exist in the home page http://smilejay.com/
function home_page()
{
	url=http://smilejay.com/
	keywords="Stay hungry"
	curl -sL $url | grep -i "$keywords"
	if [ $? -ne 0 ]; then
		WARN_MSG=$WARN_MSG"keywords '$keywords' doesn't exist on link $url.\n"
		return 1
	fi
	return 0
}

# use an array to store the return value of each monitoring function
mem_free
chk[1]=$?
load_avg
chk[2]=$?
cpu_idle
chk[3]=$?
network_tx
chk[4]=$?
httpd_mysqld
chk[5]=$?
home_page
chk[6]=$?

# send warning email to the web master if any of the check fails.
for i in $(seq 1 6)
do
	if [ ${chk[i]} -ne 0 ]; then
		printf "$WARN_MSG" | mailx -s "Warning from smilejay.com" $EMAIL
		exit 1
	fi
done
