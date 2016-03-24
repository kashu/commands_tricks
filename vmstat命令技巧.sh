vmstat - Report virtual memory statistics

SYNOPSIS
vmstat [options] [delay [count]]

DESCRIPTION
vmstat reports information about processes, memory, paging, block IO, traps, disks and cpu activity.

The  first  report  produced gives averages since the last reboot.  Additional reports give information on a sampling period of length delay.  The process and memory reports are instantaneous in either case.



$ vmstat -w 1
procs ---------------memory-------------- ---swap-- -----io---- -system-- ------cpu-----
 r  b     swpd     free     buff    cache   si   so    bi    bo   in   cs us sy id wa st
 1  0        0  5540280   188100  3843312    0    0    44    99  196  134 16  5 79  0  0
 0  0        0  5540280   188100  3843312    0    0     0     0  543 4452  3  3 94  0  0
 0  0        0  5540280   188100  3843312    0    0   128     0  989 4692  5  2 93  0  0
 0  0        0  5540032   188100  3843312    0    0     0     0  876 4286  3  3 94  0  0


每1秒更新一次，一共显示2次
$ vmstat -w 1 2
procs ---------------memory-------------- ---swap-- -----io---- -system-- ------cpu-----
 r  b     swpd     free     buff    cache   si   so    bi    bo   in   cs us sy id wa st
 2  0        0  5571992   187708  3811284    0    0    44   100  196  119 16  5 79  0  0
 0  0        0  5571984   187708  3811284    0    0     0     0  479 4204  4  2 94  0  0


$ vmstat -s
     12199284 K total memory
      6632332 K used memory
      2964588 K active memory
      3289448 K inactive memory
      5566952 K free memory
       187724 K buffer memory
      3817116 K swap cache
      1048572 K total swap
            0 K used swap
      1048572 K free swap
      2180880 non-nice user cpu ticks
        17983 nice user cpu ticks
       657294 system cpu ticks
     10806441 idle cpu ticks
        62395 IO-wait cpu ticks
          327 IRQ cpu ticks
         7946 softirq cpu ticks
            0 stolen cpu ticks
      6083984 pages paged in
     13783053 pages paged out
            0 pages swapped in
            0 pages swapped out
     69867546 interrupts
    274250751 CPU context switches
   1431317147 boot time
      2865374 forks

