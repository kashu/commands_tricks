sed练习1：
$ route -n | cat -n
     1	Kernel IP routing table
     2	Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
     3	0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 wlan0
     4	169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 wlan0
     5	192.168.1.0     0.0.0.0         255.255.255.0   U     2      0        0 wlan0
     6	192.168.122.0   0.0.0.0         255.255.255.0   U     0      0        0 virbr0

只打印首行：
$ route -n | cat -n | sed -n '1p'
     1	Kernel IP routing table

只打印最后一行：
$ route -n | cat -n | sed -n '$p'
     6	192.168.122.0   0.0.0.0         255.255.255.0   U     0      0        0 virbr0

打印3至5行：
$ route -n | cat -n | sed -n '3,5p'
     3	0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 wlan0
     4	169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 wlan0
     5	192.168.1.0     0.0.0.0         255.255.255.0   U     2      0        0 wlan0

只打印第3行和第5行（删除了第1个sed命令处理后的第二行，即实际文本中的第4行被删除了，最后留下了第3行和第5行）：
$ route -n | cat -n | sed -n '3,5p' | sed '2d'
     3	0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 wlan0
     5	192.168.1.0     0.0.0.0         255.255.255.0   U     2      0        0 wlan0

只打印第3行和第6行：
$ route -n | cat -n | sed -n '3,6p' | sed '2,3d'
     3	0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 wlan0
     6	192.168.122.0   0.0.0.0         255.255.255.0   U     0      0        0 virbr0

sed练习2：
$ who | cat -n
     1	kashu    tty7         2013-04-09 10:14
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)

在原文的第1行的下面添加内容（添加的内容位于第2行）：
$ who | cat -n | sed '1a sed command is very Powerful!'
     1	kashu    tty7         2013-04-09 10:14
sed command is very Powerful!
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)

在原文的第2行的下面添加内容（添加的内容位于第3行）：
$ who | cat -n | sed '2a sed command is very Powerful!'
     1	kashu    tty7         2013-04-09 10:14
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)
sed command is very Powerful!

在原文的第1行的上面添加内容（添加的内容位于第1行）：
$ who | cat -n | sed '1i sed command is very Powerful!'
sed command is very Powerful!
     1	kashu    tty7         2013-04-09 10:14
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)

在原文的第2行的上面添加内容（添加的内容位于第2行）：
$ who | cat -n | sed '2i sed command is very Powerful!'
     1	kashu    tty7         2013-04-09 10:14
sed command is very Powerful!
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)

在原文的最后一行的上面添加内容（添加的内容位于到数第2行）：
$ who | cat -n | sed '$i sed command is very Powerful!'
     1	kashu    tty7         2013-04-09 10:14
sed command is very Powerful!
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)

在原文的最后一行的下面添加内容（添加的内容位于最后1行）：
$ who | cat -n | sed '$a sed command is very Powerful!'
     1	kashu    tty7         2013-04-09 10:14
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)
sed command is very Powerful!

在原文的每一行的下面添加内容：
$ who | cat -n | sed 'a sed command is very Powerful!'
     1	kashu    tty7         2013-04-09 10:14
sed command is very Powerful!
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)
sed command is very Powerful!

在原文的每一行的上面添加内容：
$ who | cat -n | sed 'i sed command is very Powerful!'
sed command is very Powerful!
     1	kashu    tty7         2013-04-09 10:14
sed command is very Powerful!
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)

添加多行内容（换行的末尾要使用\）：
$ who | cat -n | sed '2a sed command is very Powerful!\
> The 2nd line\
> The 3rd line'

     1	kashu    tty7         2013-04-09 10:14
     2	kashu    pts/2        2013-04-10 15:50 (:0.0)
sed command is very Powerful!
The 2nd line
The 3rd line

sed练习3
$ free -m | cat -n
     1	             total       used       free     shared    buffers     cached
     2	Mem:          3850       3701        148          0        706       1291
     3	-/+ buffers/cache:       1703       2146
     4	Swap:          255        107        148

替换3至4行的内容：
$ free -m | cat -n | sed '3,4c Replace 3 to 4 lines'
     1	             total       used       free     shared    buffers     cached
     2	Mem:          3850       3680        169          0        676       1265
Replace 3 to 4 lines

替换2至末尾行的内容：
$ free -m | cat -n | sed '2,$c Replace 2 to the end of the lines'
     1	             total       used       free     shared    buffers     cached
Replace 2 to the end of the lines

替换所有内容：
$ free -m | cat -n | sed '1,$c Replace all lines'
Replace all lines

sed练习4
$ who
kashu    tty7         2013-04-09 10:14
kashu    pts/2        2013-04-10 15:50 (:0.0)

把kashu全部替换成KASHU：
$ who | sed 's/kashu/KASHU/g'
KASHU    tty7         2013-04-09 10:14
KASHU    pts/2        2013-04-10 15:50 (:0.0)

$ ifconfig eth0 | grep ask
          inet addr:10.40.101.10  Bcast:10.40.103.255  Mask:255.255.252.0

用sed把eth0网卡IP显示出来：
$ ifconfig eth0| grep ask | sed 's/^.*addr://g' | sed 's/Bcast.*$//g'
10.40.101.10  

上面把网卡显示出来了，但是，IP地址后面还有一个空格是多余的，通过sed把空格也删除了，只保留一个完整的IP地址：
$ ifconfig eth0| grep ask | sed 's/^.*addr://g' | sed 's/Bcast.*$//g' | sed 's/ //g' 
10.40.101.10

只显示非注释行和非空行（^#.*表示所有注释行的内容；/^$/d表示删除所有的空行）：
$ cat /etc/manpath.config | sed 's/^#.*//g' | sed '/^$/d'
MANDATORY_MANPATH			/opt/hydra/man
MANDATORY_MANPATH			/usr/man
MANDATORY_MANPATH			/usr/share/man
……
上面这条命令的结果等分别同于下面这两条命令的结果：
$ cat /etc/manpath.config | sed 's/^#.*//g' | grep -v ^$
$ egrep -v '^#|^$' /etc/manpath.config

kashu@ubuntu:/etc/rc5.d$ w
 22:42:36 up  2:21,  4 users,  load average: 0.34, 0.83, 0.90
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
kashu    tty7                      20:23    2:21m  5:40   0.34s gnome-session --session=ubuntu
kashu    pts/3    :0.0             21:01    0.00s  0.67s  0.00s w
kashu    pts/4    :0.0             21:14   21:19   0.54s 30.12s gnome-terminal
kashu    pts/5    :0.0             21:25   15:44   0.57s  0.57s bash

把以kashu开头的行的“kashu”字符串替换成“KASHU”，并且只打印出被替换的行：
kashu@ubuntu:/etc/rc5.d$ w | sed -n 's/^kashu/KASHU/p'
KASHU    tty7                      20:23    2:21m  5:40   0.34s gnome-session -
KASHU    pts/3    :0.0             21:01    0.00s  0.67s  0.00s w
KASHU    pts/4    :0.0             21:14   21:49   0.54s 30.26s gnome-terminal
KASHU    pts/5    :0.0             21:25   16:14   0.57s  0.57s bash

&符号表示替换换字符串中被找到的部份。所有含有“kashu”的行都会被替换成它自已加“er”，变成“kashuer”:
kashu@ubuntu:/etc/rc5.d$ w | sed 's/kashu/&er/g'
 22:47:03 up  2:26,  4 users,  load average: 0.45, 0.58, 0.77
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
kashuer    tty7                      20:23    2:25m  5:49   0.35s gnome-session -
kashuer    pts/3    :0.0             21:01    0.00s  0.68s  0.00s w
kashuer    pts/4    :0.0             21:14   25:46   0.54s 30.67s gnome-terminal
kashuer    pts/5    :0.0             21:25   20:11   0.57s  0.57s bash

,表示选定行的范围。所有在Mem至Swap确定的范围内的行都打印出来：
kashu@ubuntu:/etc/rc5.d$ free | sed -n '/Mem/,/Swap/p'
Mem:       3943032    3118216     824816          0     574560    1350692
-/+ buffers/cache:    1192964    2750068
Swap:       262140      18116     244024

打印第4行至数字6开头的行之间的所有行：
kashu@ubuntu:/etc/rc5.d$ w | cat -n | sed -n '4,/^6/p'
     4	kashu    pts/3    :0.0             21:01    0.00s  0.74s  0.00s w
     5	kashu    pts/4    :0.0             21:14   41:13   0.54s 32.68s gnome-terminal
     6	kashu    pts/5    :0.0             21:25   35:38   0.57s  0.57s bash

sed练习5
sed -i  直接修改文件内容（操作谨慎）

直接把test.txt文件中所有的is改成SSSS：
$ sed -i 's/is/SSSS/g' test.txt

直接把test.txt文件中的oo都删除：
$ sed -i '/oo//d' test.txt

直接在test.txt文件中首行的上面添加一行文本内容“Just a test”：
$ sed -i '1i Just a test' test.txt

直接在test.txt文件中的每一行的下面添加一行文本内容“000”：
$ sed -i 'a 000' test.txt

直接删除test.txt文件中以000开始的行：
$ sed -i '/^000/d' test.txt

sed练习6
-e  多点编辑；允许同一行里执行多个处理动作；一定要注意命令中处理动作的顺序对结果有影响！
先把1-2行删除，再把所有“kashu”替换成“KASHU”，最后在原文的第3行的上面添加一行“Just a test"
$ w | cat -n | sed -e '1,2d' -e 's/kashu/KASHU/g' -e '3i Just a test'
Just a test
     3	kashu    tty7                      09:58    2:41m  3:24   0.37s gnome-session -
     4	kashu    pts/1    :0.0             10:06    5:18   1.38s  0.04s vim /home/kashu
     5	kashu    pts/2    :0.0             11:38    0.00s  0.30s  0.00s w

先把第首行删除，再把所有的数字都替换成0：
$ w | cat -n | sed -e '1d' -e 's/[0-9]/0/g'
     0	USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
     0	kashu    tty0                      00:00    0:00m  0:00   0.00s gnome-session -
     0	kashu    pts/0    :0.0             00:00    0:00   0.00s  0.00s bash
     0	kashu    pts/0    :0.0             00:00    0.00s  0.00s  0.00s cat -n

先把第首行删除，再把首行打印出来（没有任何显示出来，因为首行已经先被删除了，所以注意处理动作的顺序对结果的影响）：
$ w | cat -n | sed -n -e '1d' -e '1p'

先把第首行删除，再把第2行打印出来
$ w | cat -n | sed -n -e '1d' -e '2p'
     0	USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT

先把第3行打印出来，再把所有的“kashu”替换成“KASHU”，最后再打印出4行和5行。仔细看最后的结果！
$ w | cat -n | sed -n -e '3p' -e '1,3d' -e 's/kashu/KASHU/g' -n -e '4,5p'
     3	kashu    tty7                      09:58    3:05m  4:19   0.42s gnome-session -
     4	KASHU    pts/1    :0.0             10:06   18:49   1.34s  1.34s bash
     5	KASHU    pts/2    :0.0             11:38    0.00s  0.58s  0.00s w
