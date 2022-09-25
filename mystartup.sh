#!/bin/sh

# hw setting
liquidctl set pump speed 100

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
done
docker exec smb service smbd start
docker exec svn service apache2 start

# start mining
/myopt/raptoreum/cpuminer-gr-avx2-1.2.4.1/bin/cpuminer.sh &
sleep 10
PID=$(pidof "cpuminer-zen3")
while true
do
        sleep 1
        busycnt=$(ps -eo %cpu,args | awk '$1 >= 3 {print}' | grep -v cpuminer-zen3 | wc -l)
        if test $busycnt -eq 0
        then
                kill -CONT $PID
        elif test $busycnt -gt 0
        then
                kill -STOP $PID
        fi
done
