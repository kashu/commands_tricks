测试写入速度
4K(1GB)
dd if=/dev/zero of=a.txt bs=4096 count=262144 conv=fdatasync

8K(1GB)
dd if=/dev/zero of=a.txt bs=8192 count=131072




while :;do killall -USR1 dd;sleep 1;done






1. dd if=/dev/zero of=test bs=64k count=16k
这个很不准确的，因为命令结束的时候数据还没有真正写到磁盘上去

2. dd if=/dev/zero of=test bs=64k count=16k conv=fsync
这个还算准确，数据已经写入磁盘

3. dd if=/dev/zero of=test bs=64k count=4k oflag=dsync
这个可以当成是模拟数据库插入操作，所以很慢
接着让我们来看看buyvm的磁盘性能

dd if=/dev/zero of=test bs=64k count=16k
1073741824 bytes (1.1 GB) copied, 2.99687 seconds, 358 MB/s

第一种方式得到的结果貌似很快
dd if=/dev/zero of=test bs=64k count=16k conv=fsync
1073741824 bytes (1.1 GB) copied, 13.9241 seconds, 77.1 MB/s

这次慢了很多，这个数据才有参考价值
dd if=/dev/zero of=test bs=64k count=2k oflag=dsync
134217728 bytes (134 MB) copied, 177.813 seconds, 755 kB/s

dd命令：http://linzhibin824.blog.163.com/blog/static/73557710201332474319645/




问: 以下几种方式测试磁盘读写速度有什么区别？

dd bs=1M count=128 if=/dev/zero of=test

dd bs=1M count=128 if=/dev/zero of=test; sync

dd bs=1M count=128 if=/dev/zero of=test conv=fdatasync

dd bs=1M count=128 if=/dev/zero of=test oflag=dsync

答：区别在于内存中写缓存的处理方式。

dd bs=1M count=128 if=/dev/zero of=test

没有加任何参数，dd默认的方式不包括“同步(sync)”命令。也就是说，dd命令完成前并没有让系统真正把文件写到磁盘上。所以以上命令只是单纯地把这128MB的数据读到内存缓冲当中(写缓存[write cache])。所以你得到的将是一个超级快的速度。因为其实dd给你的只是读取速度，直到dd完成后系统才开始真正往磁盘上写数据，但这个速度你是看不到了。所以如果这个速度很快，先不要偷着乐。呵呵

dd bs=1M count=128 if=/dev/zero of=test; sync

和前面1中的完全一样。分号隔开的只是先后两个独立的命令。当sync命令准备开始往磁盘上真正写入数据的时候，前面dd命令已经把错误的“写入速度”值显示在屏幕上了。所以你还是得不到真正的写入速度。

dd bs=1M count=128 if=/dev/zero of=test conv=fdatasync

加入这个参数后，dd命令执行到最后会真正执行一次“同步(sync)”操作，所以这时候你得到的是读取这128M数据到内存并写入到磁盘上所需的时间，这样算出来的时间才是比较符合实际的。

dd bs=1M count=128 if=/dev/zero of=test oflag=dsync

加入这个参数后，dd在执行时每次都会进行同步写入操作。也就是说，这条命令每次读取1M后就要先把这1M写入磁盘，然后再读取下面这1M，一共重复128次。这可能是最慢的一种方式了，因为基本上没有用到写缓存(write cache)。

问：那应该用哪一种呢?

答：建议使用

dd bs=1M count=128 if=/dev/zero of=test conv=fdatasync

因为这种方式最接近计算机实际操作，所以测出来的数据最有参考价值。

PS：

写： dd if=/dev/zero of=test.bin bs=4096 count=1M conv=fdatasync

# 用sync不靠谱, 最好还是在开机的时候把内存设的很小, 测试文件的大小远远大于内存才比较合理.

读： dd if=test.bin of=/dev/zero bs=4096 count=1M iflag=direct




命令
今天在commandlinefu.com网站看到这么一篇文章check the status of 'dd' in progress，试了下，效果很好。
现在一个终端中开启一个dd进程
dd if=/dev/zero of=/data3/test bs=1M count=10240
然后在另外一个终端中用while来反复执行killall命令
while sudo killall -USR1 dd; do sleep 1; done
然后就能看到间隔1秒一次的输出结果了
9996+1 records in
9996+1 records out
10481618944 bytes (10 GB) copied, 148.055 s, 70.8 MB/s
10084+1 records in
10084+1 records out
10573893632 bytes (11 GB) copied, 149.202 s, 70.9 MB/s
10239+1 records in
10239+1 records out
10736422912 bytes (11 GB) copied, 151.403 s, 70.9 MB/s
所执行的killall命令循环会在dd命令执行结束之后退出。
说明
可能不熟悉linux的人会问了，为什么dd命令的进度输出要killall命令来激发呢？其实答案很简单，dd的进度输出就是这么设计的，再详细点就是dd命令在执行的时候接收到SIGUSR1信号的输出当前的读写进度，而killall命令在这里起的作用就是给dd进程发送这个信号。
killall命令，和kill命令一样，其作用是给指定的进程发送一个信号过去，不是平常所理解的仅仅是结束一个进程，就像下面摘录的man kill里面描述的一样。
DESCRIPTION
       The command kill sends the specified signal to the specified process or process group.  If no signal is specified, the  TERM  signal  is  sent. The  TERM  signal  will  kill processes which do not catch this signal. For other processes, it may be necessary to use the  KILL  (9)  signal, since this signal cannot be caught.
所以上面的”while killall -USR1 dd; do sleep 1; done”就是每隔1秒就给所有的dd命令进程发送一个USR1信号，dd命令进程接收到信号之后就打印出自己当前的进度。
因为kill命令能传递的信号不仅仅是SIGTERM(kill pid)和SIGKILL(kill -9 pid)，还有很多其他的信号值，在这里面还有一个很经常用的就是SIGHUP(1)了，对于没有那些不与终端交互的守护进程(Deamon Process)，通常的设计是在接收到SIGHUP信号之后就会重新读取配置文件。比如下面的
# 当你对smb.conf修改之后，运行下面的命令，修改就能生效了
# 而不用再来一个smb restart
killall -HUP smbd





dd is a common Unix program whose primary purpose is the low-level copying and conversion of raw data. dd is an application that will “convert and copy a file”according to the referenced manual page for Version 7 Unix and is most likely inspired from DD found in IBM JCL, and the command’s syntax is meant to be reminiscent of this.
Learn how to use DD by visiting this site Here

Hope you enjoy

1) Duplicate several drives concurrently

dd if=/dev/sda | tee >(dd of=/dev/sdb) | dd of=/dev/sdc

If you have some drive imaging to do, you can boot into any liveCD and use a commodity machine. The drives will be written in parallel.

To improve efficiency, specify a larger block size in dd:

dd if=/dev/sda bs=64k | tee >(dd of=/dev/sdb bs=64k) | dd of=/dev/sdc bs=64kTo image more drives , insert them as additional arguments to tee:

dd if=/dev/sda | tee >(dd of=/dev/sdb) >(dd of=/dev/sdc) >(dd of=/dev/sdd) | dd of=/dev/sde


2) create an emergency swapfile when the existing swap space is getting tight

sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024000;sudo mkswap /swapfile; sudo swapon /swapfile

Create a temporary file that acts as swap space. In this example it’s a 1GB file at the root of the file system. This additional capacity is added to the existing swap space.


3) Backup your hard drive with dd

sudo dd if=/dev/sda of=/media/disk/backup/sda.backup

This will create an exact duplicate image of your hard drive that you can then restore by simply reversing the “if” & “of” locations.

sudo dd if=/media/disk/backup/sda.backup of=/dev/sdaAlternatively, you can use an SSH connection to do your backups:

dd if=/dev/sda | ssh user@ssh.server.com dd of=~/backup/sda.backup


4) Convert a Nero Image File to ISO

dd bs=1k if=image.nrg of=image.iso skip=300

This line removes the 300k header from a Nero image file converting it to ISO format


5) send DD a signal to print its progress

while :;do killall -USR1 dd;sleep 1;done

every 1sec sends DD the USR1 signal which causes DD to print its progress.

6) show dd progress part 2

killall -USR1 dd

if you need see progress of long dd command, enter subj on other console

7) How to copy CD/DVD into hard disk (.iso)

dd if=/dev/cdrom of=whatever.iso

A dear friend of mine asked me how do I copy a DVD to your hard drive? If you want to make a copy of the ISO image that was burned to a CD or DVD, insert that medium into your CD/DVD drive and (assuming /dev/cdrom is associated with your computer?s CD drive) type the following command

8) Watch the progress of ‘dd’

dd if=/dev/zero | pv | dd of=/dev/null

need pv (pipe view) :

http://www.ivarch.com/programs/pv.shtml

9) Clone IDE Hard Disk

sudo dd if=/dev/hda1 of=/dev/hdb2

This command clone the first partition of the primary master IDE drive to the second partition

of the primary slave IDE drive (!!! back up all data before trying anything like this !!!)

10) Test network speed without wasting disk

dd if=/dev/zero bs=4096 count=1048576 | ssh user@host.tld 'cat > /dev/null'
The above command will send 4GB of data from one host to the next over the network, without consuming any unnecessary disk on either the client nor the host. This is a quick and dirty way to benchmark network speed without wasting any time or disk space.

Of course, change the byte size and count as necessary.

This command also doesn’t rely on any extra 3rd party utilities, as dd, ssh, cat, /dev/zero and /dev/null are installed on all major Unix-like operating systems.

11) clone a hard drive to a remote directory via ssh tunnel, and compressing the image

dd if=/dev/sda | gzip -c | ssh user@ip 'dd of=/mnt/backups/sda.dd'

