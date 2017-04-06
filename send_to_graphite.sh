#/usr/bin/bash

ARC=`uname -m`

if [ "${ARC}" = "i86pc" ]
  then
    /var/tmp/perf/sysdispqlen.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/iosizei86.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/iopsi86.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/sysc.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/diskioi86.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/sd_qd.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/vmstat.pl | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/nicstati86.pl | /var/tmp/perf/to_graphite.rb
  else
    /var/tmp/perf/sysdispqlen.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/iosize.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/iops.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/sysc.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/diskio.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/ssd_qd.d | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/vmstat.pl | /var/tmp/perf/to_graphite.rb &
    sleep 1
    /var/tmp/perf/nicstat.pl | /var/tmp/perf/to_graphite.rb
fi
