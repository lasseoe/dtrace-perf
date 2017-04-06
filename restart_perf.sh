#! /bin/bash

dots()
{
COUNTER=0
while kill -0 ${PID}
 do
   echo -n "."
   sleep 1
   COUNTER=`expr ${COUNTER} + 1`
   if [ ${COUNTER} -eq 60 ]
    then
      COUNTER=0
      printf "\n"
   fi
 done 2> /dev/null
 printf "\n Processing done \n"

}

restart_perf()
{
ARC=`uname -m`
   if [ "${ARC}" = "i86pc" ]
     then
       cd /var/tmp/perf
       ps -ef | egrep "dtrace|nicstati86.pl|vmstat.pl|send_to" | grep -v egrep | awk '{print $2}' | xargs kill -9
       rm nohup.out
       nohup ./send_to_graphite.sh &
       clear
       echo "Waiting 10 secs for the processes to start"
       sleep 10
       ps -ef | egrep "dtrace|nicstati86.pl|vmstat.pl|send_to" | grep -v egrep
    else
       cd /var/tmp/perf
       ps -ef | egrep "dtrace|nicstat.pl|vmstat.pl|send_to" | grep -v egrep | awk '{print $2}' | xargs kill -9
       rm nohup.out
       nohup ./send_to_graphite.sh &
       clear
       echo "Waiting 10 secs for the processes to start"
       sleep 10
       ps -ef | egrep "dtrace|nicstat.pl|vmstat.pl|send_to" | grep -v egrep
   fi
}

restart_perf

