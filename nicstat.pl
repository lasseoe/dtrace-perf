#!/usr/bin/perl
#
use Sun::Solaris::Kstat;

$iface = '';

my $kstat = Sun::Solaris::Kstat->new();

#my @inst=`dladm show-aggr -p |grep link | cut -d'=' -f 3 | awk '{print \$1}' `;
my @inst=`dladm show-dev | grep "link: up" | grep -v usb | awk '{print \$1}' `;
#my @inst="ixgbe0";

foreach $a (@inst) {
  chomp($a);

  my($a_iface) = $a =~ /^(.*?)\d+$/;
  my($a_i) = $a =~ /(\d+)$/;

  ($t_stats{$a}{rbytes64}, $t_stats{$a}{obytes64}) = @{$kstat->{$a_iface}{$a_i}{mac}}{qw(rbytes64 obytes64)};
  $t_stats{$a}{ifspeed} = $kstat->{$a_iface}{$a_i}{mac}{ifspeed}/8;

}

while (1)
{
   sleep 1;
   if ($kstat->update()) { }

   foreach $interface (@inst)
   {
     chomp($interface);

     my($iface) = $interface =~ /^(.*?)\d+$/;
     my($inst) = $interface =~ /(\d+)$/;

     ($stats{$interface}{rbytes64}, $stats{$interface}{obytes64}) = @{$kstat->{$iface}{$inst}{mac}}{qw(rbytes64 obytes64)};
     $rbytes = eval { ($stats{$interface}{rbytes64} - $t_stats{$interface}{rbytes64})  };
     $obytes = eval { ($stats{$interface}{obytes64} - $t_stats{$interface}{obytes64})  };
     $rpct = eval { (($stats{$interface}{rbytes64} - $t_stats{$interface}{rbytes64}) / $t_stats{$interface}{ifspeed}) * 100 };
     $opct = eval { (($stats{$interface}{obytes64} - $t_stats{$interface}{obytes64}) / $t_stats{$interface}{ifspeed}) * 100 };

     printf ("CHANGE_ME.net.$iface$inst.rbytes $rbytes  \n");
     printf ("CHANGE_ME.net.$iface$inst.obytes $obytes \n");
     printf ("CHANGE_ME.net.$iface$inst.rpct %.2f \n", $rpct);
     printf ("CHANGE_ME.net.$iface$inst.opct %.2f \n", $opct);


     $t_stats{$interface}{rbytes64} = $stats{$interface}{rbytes64}; $t_stats{$interface}{obytes64} = $stats{$interface}{obytes64};
   }
}


