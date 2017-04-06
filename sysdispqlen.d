#!/usr/sbin/dtrace -qs

#pragma D option quiet
#pragma D option bufsize=16m
#pragma D option dynvarsize=2m
#pragma D option cleanrate=333hz

profile:::profile-1001hz
{
	@["CHANGE_ME.cpu.dispqlen:"] =
	    sum(curthread->t_cpu->cpu_disp->disp_nrunnable);
}

profile:::tick-1sec
{
	normalize(@, 1001);
	printa("CHANGE_ME.cpu.dispqlen %@d\n",@);
	trunc(@);
}

