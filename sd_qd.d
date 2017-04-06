#!/usr/sbin/dtrace -qs

#pragma D option quiet
/* #pragma D option bufsize=8m */
#pragma D option dynvarsize=2m
#pragma D option cleanrate=333hz

fbt::sd_start_cmds:entry
{

}

fbt::sd_start_cmds:entry
{
        @qd = max(args[0]->un_ncmds_in_driver);
}

tick-1s
{
        printa("CHANGE_ME.io.queuedepth.max %@d\n", @qd);
        trunc(@qd);
}

