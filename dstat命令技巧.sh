DESCRIPTION
Dstat is a versatile replacement for vmstat, iostat and ifstat. Dstat overcomes some of the limitations and adds some extra features.

Dstat allows you to view all of your system resources instantly, you can eg. compare disk usage in combination with interrupts from your IDE controller, or compare the network bandwidth numbers directly with the disk throughput (in the same interval).

Dstat also cleverly gives you the most detailed information in columns and clearly indicates in what magnitude and unit the output is displayed. Less confusion, less mistakes, more efficient.

Dstat is unique in letting you aggregate block device throughput for a certain diskset or network bandwidth for a group of interfaces, ie. you can see the throughput for all the block devices that make up a single filesystem or storage system.

Dstat allows its data to be directly written to a CSV file to be imported and used by OpenOffice, Gnumeric or Excel to create graphs.

Note: Users of Sleuthkit might find Sleuthkit’s dstat being renamed to datastat to avoid a name conflict. See Debian bug #283709 for more information.





#查看各个（指定）硬盘的IO情况
I like dstat. It can show totals and statistics per disk and even md-devices (RAID), also can use colors for better overview:

$ dstat -tdD total,sda,sdb,sdc,md1 60 
----system---- -dsk/total----dsk/sda-----dsk/sdb-----dsk/sdc-----dsk/md1--
     time     | read  writ: read  writ: read  writ: read  writ: read  writ
08-11 22:08:17|3549k  277k: 144k   28k: 851k   62k: 852k   60k:  25k   82k
08-11 22:09:17|  60k  258k:1775B   15k:  13k   63k:  15k   60k:  68B   74k
08-11 22:10:17| 176k  499k:   0    14k:  41k  122k:  41k  125k: 273B  157k
08-11 22:11:17|  42k  230k:   0    14k:9830B   54k:  14k   51k:   0    70k
08-11 22:11:52|  28k  132k:   0  5032B:5266B   33k:9479B   28k:   0    37k
-t for timestamps
-d for disk statistics
-D to specify the exact devices to report
60 to average over 60 seconds. The display is updated every second, but only once per 60 seconds a new line will be started.

not used in this example, but -c can report wait IO percentage, which in most cases is related to the CPU waiting for data from the disks.

It is available for most Linux distributions, but sometimes needs to be installed from repositories.





$ dstat -lcdnmspyt

#统计数据显示在屏幕上的同时输出到dstat.csv文件中
$ dstat -lcdnmspyt --output dstat.csv
---load-avg--- ----total-cpu-usage---- -dsk/total- -net/total- ------memory-usage----- ----swap--- ---procs--- ---system-- ----system----
 1m   5m  15m |usr sys idl wai hiq siq| read  writ| recv  send| used  buff  cach  free| used  free|run blk new| int   csw |     time     
0.16 0.52 0.59|  5   2  92   1   0   0|  75k  125k|   0     0 |2215M  189M 3292M 6218M|   0  1024M|0.0   0  48| 684  2646 |11-05 18:33:51
0.16 0.52 0.59|  2   1  97   0   0   0|   0     0 | 371k   20k|2214M  189M 3292M 6218M|   0  1024M|2.0   0   0| 703  1177 |11-05 18:33:52
0.16 0.52 0.59|  3   1  95   2   0   0|   0   204k| 370k   20k|2214M  189M 3293M 6218M|   0  1024M|1.0   0   0| 757  1341 |11-05 18:33:53
0.16 0.52 0.59|  2   1  97   1   0   0|   0    44k| 371k   20k|2218M  189M 3293M 6214M|   0  1024M|1.0   0   0| 729  1303 |11-05 18:33:54
0.15 0.51 0.59|  2   1  97   0   0   0|   0     0 | 370k   18k|2218M  189M 3294M 6213M|   0  1024M|2.0   0   0| 725  1235 |11-05 18:33:55
0.15 0.51 0.59|  2   2  96   0   0   0|   0     0 | 371k   19k|2218M  189M 3294M 6213M|   0  1024M|1.0   0   0| 739  1367 |11-05 18:33:56
0.15 0.51 0.59|  2   1  94   3   0   0|   0    84k| 371k   18k|2218M  189M 3294M 6213M|   0  1024M|3.0 1.0   0| 730  1346 |11-05 18:33:57
0.15 0.51 0.59|  3   1  95   1   0   0|   0    20k| 368k   18k|2218M  189M 3295M 6213M|   0  1024M|1.0   0   0| 734  1324 |11-05 18:33:58



$ sudo dstat -lcdnmspyt -N eth0 --proc-count --net-packets --disk-util
---load-avg--- ----total-cpu-usage---- -dsk/total- --net/eth0- ------memory-usage----- ----swap--- ---procs--- ---system-- ----system---- proc --pkt/eth0- sda--sdb-
 1m   5m  15m |usr sys idl wai hiq siq| read  writ| recv  send| used  buff  cach  free| used  free|run blk new| int   csw |     time     |tota|#recv #send|util:util
0.16 0.13 0.19| 16   5  78   0   0   0|  27k   66k|   0     0 |2330M  182M 3724M 5677M|   0  1024M|  0   0  14| 345  1345 |13-05 19:22:15| 207|   0     0 |1.30:0.00
0.16 0.13 0.19|  2   1  97   0   0   0| 128k   48k| 158B   98B|2331M  182M 3724M 5676M|   0  1024M|1.0   0   0| 204   987 |13-05 19:22:16| 207|2.00  1.00 |0.40:   0
0.15 0.13 0.19|  3   1  97   0   0   0|   0     0 | 158B   98B|2330M  182M 3724M 5677M|   0  1024M|1.0   0   0| 184   912 |13-05 19:22:17| 207|2.00  1.00 |   0:   0
0.15 0.13 0.19|  3   5  91   0   0   0|   0     0 | 158B   98B|2331M  182M 3724M 5676M|   0  1024M|1.0   0 663| 272  2396 |13-05 19:22:18| 207|2.00  1.00 |   0:   0
0.15 0.13 0.19|  2   1  97   0   0   0|   0     0 | 158B   98B|2331M  182M 3724M 5676M|   0  1024M|1.0   0   0| 176   885 |13-05 19:22:19| 207|2.00  1.00 |   0:   0
0.15 0.13 0.19|  2   0  98   0   0   0|   0     0 | 158B   98B|2331M  182M 3720M 5680M|   0  1024M|1.0   0   0| 181   913 |13-05 19:22:20| 207|2.00  1.00 |   0:   0^C



-f, --full	automatically expand -C, -D, -I, -N and -S lists
$ dstat -f
You did not select any stats, using -cdngy by default.
-------cpu0-usage--------------cpu1-usage--------------cpu2-usage--------------cpu3-usage------ --dsk/sda-----dsk/sdb-- --net/eth0---net/wlan0- ---paging-- ---system--
usr sys idl wai hiq siq:usr sys idl wai hiq siq:usr sys idl wai hiq siq:usr sys idl wai hiq siq| read  writ: read  writ| recv  send: recv  send|  in   out | int   csw 
  7   2  91   1   0   0: 40  10  50   0   0   0: 34  12  53   0   0   0: 36  10  53   0   0   0|  27k   67k:  13B    0 |   0     0 :   0     0 |   0     0 | 345  1346 
  5   1  94   0   0   0:  1   0  99   0   0   0:  1   0  99   0   0   0:  1   0  99   0   0   0|   0     0 :   0     0 |  98B   98B:   0     0 |   0     0 | 177   913 
  3   0  97   0   0   0:  1   0  99   0   0   0:  2   1  97   0   0   0:  4   0  92   4   0   0|   0    12k:   0     0 |  98B   98B:   0     0 |   0     0 | 191  1023 
  8   1  91   0   0   0:  3   1  96   0   0   0:  0   0 100   0   0   0:  2   1  97   0   0   0|   0     0 :   0     0 |  98B   98B:   0     0 |   0     0 | 631  1258 ^C



$ dstat --list
dstat --list
internal:
	aio, cpu, cpu24, disk, disk24, disk24old, epoch, fs, int, int24, io, ipc, load, lock, mem, net, page, page24, proc, raw, socket, swap, 
	swapold, sys, tcp, time, udp, unix, vm
/usr/share/dstat:
	battery, battery-remain, cpufreq, dbus, disk-tps, disk-util, dstat, dstat-cpu, dstat-ctxt, dstat-mem, fan, freespace, gpfs, gpfs-ops, 
	helloworld, innodb-buffer, innodb-io, innodb-ops, lustre, memcache-hits, mysql-io, mysql-keys, mysql5-cmds, mysql5-io, mysql5-keys, 
	net-packets, nfs3, nfs3-ops, nfsd3, nfsd3-ops, ntp, postfix, power, proc-count, qmail, rpc, rpcd, sendmail, snooze, squid, test, 
	thermal, top-bio, top-bio-adv, top-childwait, top-cpu, top-cpu-adv, top-cputime, top-cputime-avg, top-int, top-io, top-io-adv, 
	top-latency, top-latency-avg, top-mem, top-oom, utmp, vm-memctl, vmk-hba, vmk-int, vmk-nic, vz-cpu, vz-io, vz-ubc, wifi




dstat -c --top-cpu -d --top-bio --top-latency
----total-cpu-usage---- -most-expensive- -dsk/total- ----most-expensive---- --highest-total--
usr sys idl wai hiq siq|  cpu process   | read  writ|  block i/o process   | latency process 
  6   2  92   0   0   0|chromium-brow1.0| 138k 8412k|
            23k   34k|chromium-brow3983
  2   1  97   1   0   0|*Aut         0.5|   0   204k|chromium-br   0   168k|dbus-daemon   525
  3   1  96   0   0   0|X            0.8|   0     0 |                      |rcu_sched    1575
  3   1  96   0   0   0|*Aut         1.8|   0     0 |                      |conky        6444
  2   1  97   0   0   0|*Aut         0.5|   0     0 |                      |wrapper-2.0   341
  2   1  97   0   0   0|*Aut         0.2|   0     0 |                      |conky        2737
  2   1  96   0   0   0|*Aut         0.5|   0    44k|                      |rcu_sched     594
  3   1  96   0   0   0|*Aut         1.2|   0     0 |                      |rcu_sched    1412
  2   1  96   0   0   0|conky        0.8|   0   152k|chromium-br   0    32k|*Aut          731

