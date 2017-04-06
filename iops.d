#!/usr/sbin/dtrace -qs

#pragma D option quiet
#pragma D option bufsize=16m
#pragma D option dynvarsize=2m
#pragma D option cleanrate=333hz

io:::start
/args[1]->dev_name=="ssd"/
{ 
	start[arg0] = timestamp;
} 
  
io:::done 
/start[arg0]/
{
	@iops["Block IOPS"] = count();
	start[arg0] = 0;
}

tick-1s
{
	printa("CHANGE_ME.iops %@d\n", @iops);
	trunc(@iops);
}
