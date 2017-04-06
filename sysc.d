#!/usr/sbin/dtrace -qs

#pragma D option quiet
#pragma D option bufsize=16m
#pragma D option dynvarsize=2m
#pragma D option cleanrate=333hz

sysinfo::preempt:inv_swtch
{
    @icsw["Inv CSW"] = count();
}

sysinfo:::pswitch
{
    @csw["CSW"] = count(); 
}

sysinfo:::xcalls
{
    @xcalls["Crosscalls"] = count(); 
}

syscall:::entry
{
        @syscalls["syscalls"] = count();
}

tick-1s
{
  printa("CHANGE_ME.cpu.csw %@d\n", @csw);
  printa("CHANGE_ME.cpu.icsw %@d\n", @icsw);
  printa("CHANGE_ME.cpu.xcalls %@d\n", @xcalls);
  printa("CHANGE_ME.syscalls %@d\n", @syscalls);
  trunc(@syscalls);
  trunc(@csw);
  trunc(@icsw);
  trunc(@xcalls);
}
