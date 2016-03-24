Another Benchmark
Several days ago, Keith-Winstein replied at the Quora Posts mentioned that my previous benchmark cannot be reproduced due to the time of all deletion operations lasting too long. To make it clear, those weird data might be that my computer was under heavy load in the past years that it may exist some fs errors during the previous benchmarks. Yet, I am not sure about it. Anyway, I got myself a relatively new rackable computer and did the benchmark again. This time I used /usr/bin/time that offers more detail results. Here is the new result,

(The # of files is 1000000. Each of them has 0 size.)

Command	Elapsed	System Time	%CPU	cs1 (Vol/Invol)
rsync -a –delete empty/ a	10.60	1.31	95	106/22
find b/ -type f -delete	28.51	14.46	52	14849/11
find c/ -type f | xargs -L 100 rm2	41.69	20.60	54	37048/15074
find d/ -type f | xargs -L 100 -P 100 rm2	34.32	27.82	89	929897/21720
rm -rf f	31.29	14.80	47	15134/11
Original Output
# method 1
~/test $ /usr/bin/time -v  rsync -a --delete empty/ a/
        Command being timed: "rsync -a --delete empty/ a/"
        User time (seconds): 1.31
        System time (seconds): 10.60
        Percent of CPU this job got: 95%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:12.42
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 24378
        Voluntary context switches: 106
        Involuntary context switches: 22
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

# method 2
        Command being timed: "find b/ -type f -delete"
        User time (seconds): 0.41
        System time (seconds): 14.46
        Percent of CPU this job got: 52%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:28.51
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 11749
        Voluntary context switches: 14849
        Involuntary context switches: 11
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0
# method 3
find c/ -type f | xargs -L 100 rm
~/test $ /usr/bin/time -v ./delete.sh
        Command being timed: "./delete.sh"
        User time (seconds): 2.06
        System time (seconds): 20.60
        Percent of CPU this job got: 54%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:41.69
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 1764225
        Voluntary context switches: 37048
        Involuntary context switches: 15074
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

# method 4
find d/ -type f | xargs -L 100 -P 100 rm
~/test $ /usr/bin/time -v ./delete.sh
        Command being timed: "./delete.sh"
        User time (seconds): 2.86
        System time (seconds): 27.82
        Percent of CPU this job got: 89%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:34.32
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 1764278
        Voluntary context switches: 929897
        Involuntary context switches: 21720
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

# method 5
~/test $ /usr/bin/time -v rm -rf f
        Command being timed: "rm -rf f"
        User time (seconds): 0.20
        System time (seconds): 14.80
        Percent of CPU this job got: 47%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:31.29
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 176
        Voluntary context switches: 15134
        Involuntary context switches: 11
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0
The Original Benchmark
Yesterday, I saw a very interesting method for deleting huge number of files in a single directory. The method is provided by Zhenyu Lee at

http://www.quora.com/How-can-someone-rapidly-delete-400-000-files

Instead of using find and xargs, Lee ingeniously takes the advantage of rsync that he uses rsync –delete to sync the target directory with an empty directory. Later, I did a comparasion on various method that I've used. To my surprise, Lee's method is much faster than others. The following is my benchmark,

Environment:

CPU: Intel(R) Core(TM)2 Duo CPU E8400 @ 3.00GHz
MEM: 4G
HD: ST3250318AS: 250G/7200RPM
Method	# Of Files	Deletion Time
rsync -a –delete empty/ s1/	1000000	6m50.638s
find s2/ -type f -delete	1000000	87m38.826s
find s3/ -type f | xargs -L 100 rm	1000000	83m36.851s
find s4/ -type f | xargs -L 100 -P 100 rm	1000000	78m4.658s
rm -rf s5	1000000	80m33.434s
With –delete and –exclude, it enables to delete files according to some patterns. Moreover, it is useful when one have to keep the directory itself for some other purpose.

Now I am really curious about why Lee's method is much faster than others, even rm -rf. If anyone have any idea about it, comment here. Thanks very much.

Footnotes:
1
Voluntary Context Switches and Involuntary Context Switches from /usr/bin/time

2
As there is pipeline, in order to make an accurate result, practically the command is wrapped by a bash script

Here is the hardware specification,

Summary:        HP DL360 G7, 2 x Xeon E5620 2.40GHz, 23.5GB / 24GB 1333MHz
Processors:     2 (of 16) x Xeon E5620 2.40GHz (16 cores)
Memory: 23.5GB
Disk:           cciss/c0d0 (cciss0): 300GB (4%) RAID-10
Disk-Control:   cciss0: Hewlett-Packard Company Smart Array G6 controllers, FW 3.66
OS:             RHEL Server 5.4 (Tikanga), Linux 2.6.18-164.el5 x86_64, 64-bit
