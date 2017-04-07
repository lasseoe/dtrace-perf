#!/usr/sbin/dtrace -qs

#pragma D option quiet
#pragma D option bufsize=8m
#pragma D option dynvarsize=2m
#pragma D option cleanrate=333hz

io:::start
/args[1]->dev_name=="ssd"/
{
/*       printf("dev=%s + %s + %s\n", args[1]->dev_name,  args[1]->dev_statname ,  args[1]->dev_pathname); */
        start[arg0] = timestamp;
}

io:::done
/start[arg0] && args[0]->b_flags & B_READ/
{
        @rlat["block read I/O latency (us)"] = avg((timestamp - start[arg0])/1000);
        @riops["read ops (us)"] = count();
        start[arg0] = 0;
}

io:::done
/start[arg0] && args[0]->b_flags & B_WRITE/
{
        @wlat["block write write I/O latency (us)"] = avg((timestamp - start[arg0])/1000);
        @wiops["write ops (us)"] = count();
        start[arg0] = 0;
}

tick-1s
{
  printa("CHANGE_ME.io.r.latency_avg %@d\n", @rlat);
  printa("CHANGE_ME.io.w.latency_avg %@d\n", @wlat);
  printa("CHANGE_ME.io.r.iops %@d\n", @riops);
  printa("CHANGE_ME.io.w.iops %@d\n", @wiops);
  trunc(@riops); trunc(@wiops);
  trunc(@rlat); trunc(@wlat);
}

