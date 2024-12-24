#!/bin/sh

# hw setting
## wol setting
ethtool --change enp7s0 wol g

# start containers
while true
do
	sleep 1
	if curl -s --unix-socket /var/run/docker.sock http/_ping 2>&1 >/dev/null
	then
		break
	fi
done
for containerId in $(docker ps -a -q)
do
	docker restart $containerId
	docker exec $containerId service ssh start
	docker exec $containerId service xrdp start
	docker exec $containerId service cron start
	docker exec -d $containerId code-server
	docker exec -d $containerId code-server_cert.sh
done
docker exec smb service smbd start
docker exec svn service apache2 start

# start windows virtual machine
/myopt/portmap_streaming.sh
virsh start win11
virsh start ubuntu22.04

# start try sleep (final opt action 1)
timecnt=0
while true
do
        sleep 1
        timecnt=$((timecnt+1))

        # check time reset
        #codeserverpscnt=$(ps aux | grep code-server | wc | awk '{print $1;}')
        #if [ $codeserverpscnt -gt 4 ]
        #then
        #        date >> /tmp/whynotsleep.log
        #        echo "codeserverpscnt:$codeserverpscnt" >> /tmp/whynotsleep.log
        #        timecnt=0
	#	continue
        #fi

        #ptscnt=$(who | grep pts | wc | awk '{print $1;}')
        #if [ $ptscnt -gt 0 ]
        #then
        #        date >> /tmp/whynotsleep.log
        #        echo "ptscnt:$ptscnt" >> /tmp/whynotsleep.log
        #        timecnt=0
	#	continue
        #fi

	ldavg=$(cat /proc/loadavg | awk '{print $1;}')
	ldavg_ret=$(echo "$ldavg > 2.0" | bc)
        if [ $ldavg_ret -eq "1" ]
        then
                date >> /tmp/whynotsleep.log
                echo "ldavg:$ldavg" >> /tmp/whynotsleep.log
                timecnt=0
		continue
        fi

        hour=$(date +%H)
        dow=$(date +%u) # 1 is Monday
        if [ "$hour" -ge 23 -a "$dow" -eq 4 ]
        then
                date >> /tmp/whynotsleep.log
                echo "hourdow" >> /tmp/whynotsleep.log
                timecnt=0
		continue
        elif [ "$hour" -le 6 -a "$dow" -eq 5 ]
        then
                date >> /tmp/whynotsleep.log
                echo "hourdow" >> /tmp/whynotsleep.log
                timecnt=0
		continue
        fi

        if [ -f /tmp/nosleep ]
        then
                date >> /tmp/whynotsleep.log
                echo "nosleep flag" >> /tmp/whynotsleep.log
                timecnt=0
		continue
        fi

        # desicion
        if [ "$timecnt" -gt 21600 ]
        then
                timecnt=0

                time_t=$(date -dthursday +%s)
                time_t=$((time_t+86100))

                time_n=$(date +%s)

                if [ $time_n -gt $time_t ]
                then
                        time_t=$((time_t+604800))
                fi

                echo "wakealarm:$time_t" > /tmp/whynotsleep.log

                echo 0 > /sys/class/rtc/rtc0/wakealarm
                echo $time_t > /sys/class/rtc/rtc0/wakealarm
		systemctl suspend
        fi
done
