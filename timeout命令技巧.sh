Start COMMAND, and kill it if still running after 5 seconds

$ timeout 5s ping localhost
PING localhost.localdomain (127.0.0.1) 56(84) bytes of data.
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=1 ttl=64 time=0.080 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=2 ttl=64 time=0.055 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=3 ttl=64 time=0.063 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=4 ttl=64 time=0.056 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=5 ttl=64 time=0.043 ms


$ timeout 4s dstat -lcdnmspyt -N eth0
---load-avg--- ----total-cpu-usage---- -dsk/total- --net/eth0- ------memory-usage----- ----swap--- ---procs--- ---system-- ----system----
 1m   5m  15m |usr sys idl wai hiq siq| read  writ| recv  send| used  buff  cach  free| used  free|run blk new| int   csw |     time     
0.13 0.39 0.63| 13   3  83   1   0   0|  49k   95k|   0     0 |3247M  251M 2682M 5732M|   0  1024M|  0   0  32|1362  5781 |18-05 02:36:00
0.13 0.39 0.63|  2   1  98   0   0   0|   0     0 |  10k  814B|3253M  251M 2683M 5726M|   0  1024M|  0   0   0| 639  1458 |18-05 02:36:01
0.12 0.39 0.62|  2   1  98   0   0   0|   0     0 |  10k  814B|3253M  251M 2683M 5726M|   0  1024M|  0   0   0| 638  1462 |18-05 02:36:02
0.12 0.39 0.62|  1   1  98   0   0   0|   0     0 |  10k  806B|3253M  251M 2683M 5726M|   0  1024M|  0   0   0| 651  1429 |18-05 02:36:03


$ timeout 3s vmstat -w 1
procs ---------------memory-------------- ---swap-- -----io---- -system-- ------cpu-----
 r  b     swpd     free     buff    cache   si   so    bi    bo   in   cs us sy id wa st
 0  0        0  5867184   257388  2750832    0    0    13    24   93  204 13  3 83  1  0
 0  0        0  5867060   257396  2750824    0    0     0    60  690 1634  2  1 96  2  0
 0  0        0  5867052   257396  2750832    0    0     0     0  657 1497  2  1 98  0  0
