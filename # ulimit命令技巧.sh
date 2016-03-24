[root@www ~]# ulimit [-SHacdfltu] [配额]
选项与参数：
-H  ：hard limit ，严格的配置，必定不能超过这个配置的数值；
-S  ：soft limit ，警告的配置，可以超过这个配置值，但是若超过则有警告信息。
      在配置上，通常 soft 会比 hard 小，举例来说，soft 可配置为 80 而 hard 
      配置为 100，那么你可以使用到 90 (因为没有超过 100)，但介于 80~100 之间时，
      系统会有警告信息通知你！
-a  ：后面不接任何选项与参数，可列出所有的限制额度；
-c  ：当某些程序发生错误时，系统可能会将该程序在内存中的信息写成文件(除错用)，
      这种文件就被称为核心文件(core file)。此为限制每个核心文件的最大容量。
-f  ：此 shell 可以创建的最大文件容量(一般可能配置为 2GB)单位为 Kbytes
-d  ：程序可使用的最大断裂内存(segment)容量；
-l  ：可用于锁定 (lock) 的内存量
-t  ：可使用的最大 CPU 时间 (单位为秒)
-u  ：单一用户可以使用的最大程序(process)数量。
Whether it is user intention or just accident it may happen, that a single user can eat up all available system resources such as RAM memory or disk space. Depends on the nature of you Linux system you may want to limit your users to only what they might actually need.

Let's start with something like a fork bomb:

:(){ :|:& };:
The line above can almost instantly consume all resources since it creates recursive function all to it self as it forks unlimited children processes. One does not even need a root privileges to crash your Linux system. What about to limit user by a number of process he/she can spawn:

NOTE: All limits are applied to a current bash shell session only. To make a permanent change system wide use /etc/profile .

$ ulimit -u 10
$ :(){ :|:& };:
bash: fork: retry: Resource temporarily unavailable
This takes care of the fork bomb problem. But what about disk space? Linux command ulimit can limit users to create files bigger than a certain size:

$ ulimit -f 100
$ cat /dev/zero > file
File size limit exceeded (core dumped)
$ ls -lh file
-rw-rw-r--. 1 linux commands 100K Feb 21 18:27 file 
Some extreme examples:

With ulimit it is also possible to limit a maximum amount of virtual memory available to the process:

ulimit -v 1000
[lilo@localhost ~]$ ls
ls: error while loading shared libraries: libc.so.6: failed to map segment from shared object: Cannot allocate memory
Limit a user by number of opened files ( file descriptors )

$ ulimit -n 0
$ echo ulimit > command
bash: command: Too many open files
To check all your current limits use -a option:

$ ulimit -a
