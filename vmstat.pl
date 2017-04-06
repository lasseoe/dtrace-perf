#!/usr/bin/perl

open(VM, "vmstat -q 1 |") or die;


select(STDOUT); # default
$| = 1;

while(<VM>)
{
  @vmstat = split(/\s+/);
  if($vmstat[1] =~ /^\d+$/) {
    printf("CHANGE_ME.kthr.r %d\n", $vmstat[1]);
    printf("CHANGE_ME.kthr.b %d\n", $vmstat[2]);
    printf("CHANGE_ME.cpu.usr %d\n", $vmstat[20]);
    printf("CHANGE_ME.cpu.sys %d\n", $vmstat[21]);
  }
}
close(VM);

