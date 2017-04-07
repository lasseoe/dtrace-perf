#!/usr/sbin/dtrace -qs

#pragma D option quiet
#pragma D option bufsize=16m
#pragma D option dynvarsize=2m
#pragma D option cleanrate=333hz

io:::done
/args[1]->dev_name=="sd"/
{
        @iosize["size"] = sum(args[0]->b_bcount);
        start[arg0] = 0;
}

io:::done
/args[1]->dev_name=="sd" && args[0]->b_flags & B_READ/
{
        @riosize["rsize"] = sum(args[0]->b_bcount);
        start[arg0] = 0;
}

io:::done
/args[1]->dev_name=="sd" && args[0]->b_flags & B_WRITE/
{
        @wiosize["wsize"] = sum(args[0]->b_bcount);
        start[arg0] = 0;
}

tick-1s
{
        printa("CHANGE_ME.iosize %@d\n", @iosize);
        printa("CHANGE_ME.iosizeread %@d\n", @riosize);
        printa("CHANGE_ME.iosizewrite %@d\n", @wiosize);
        trunc(@iosize);
        trunc(@riosize);
        trunc(@wiosize);
}

