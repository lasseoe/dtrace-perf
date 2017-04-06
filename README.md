# dtrace-perf
DTrace scripts for Solaris, outputs in a statsd/Graphite consumable format

This is noting short of a hack. It was thrown together when we had massive performance challenges on a bunch of large Oracle SPARC servers running Solaris 10 and Oracle RDBMS, and later various x64 machines.
I formatted the output so we could send it straight into Graphite, and visualize using Grafana.

It's ugly, some dtrace scripts may return values lower or higher than the actual values, however it gaves us a good enough ooverview of what is happening.

Use at your own risk, and don't run this 24/7, it's meant as an adhoc tool.

