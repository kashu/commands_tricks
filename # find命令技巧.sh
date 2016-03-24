通过文件名查找法： 
这个方法说起来就和在WINDOWS下查找文件一样容易理解了。如果你把这个文件放在单个的文件夹里面，只要使用常见的“ls"命令就能方便的查找出来， 那么使用“find”命令来查找它就不能给你留下深刻的印象，毕竟“find”命令的强大功能不止这个。如果知道了某个文件的文件名，而不知道这个文件放 到哪个文件夹，甚至是层层套嵌的文件夹里。举例说明，假设你忘记了httpd.conf这个文件在系统的哪个目录下，甚至在系统的某个地方也不知道，则这 是可以使用如下命令： 
find / -name httpd.conf 

这个命令语法看起来很容易就明白了，就是直接在find后面写上 -name，表明要求系统按照文件名查找，最后写上httpd.conf这个目标文件名即可。稍等一会系统会在计算机屏幕上显示出查找结果列表： 
/etc/httpd/conf/httpd.conf

这就是httpd.conf这个文件在Linux系统中的完整路径。查找成功。 
如果输入以上查找命令后系统并没有显示出结果，那么不要以为系统没有执行find / -name httpd.conf命令，而可能是你的系统中没有安装Apache服务器，这时只要你安装了Apache Web服务器，然后再使用find / -name httpd.conf就能找到这个配置文件了。 

无错误查找技巧： 
在Linux系统中“find”命令是大多数系统用户都可以使用的命令，并不是ROOT系统管理员的专利。但是普通用户使用“find”命令时也有可能遇 到这样的问题，那就是Linux系统中系统管理员ROOT可以把某些文件目录设置成禁止访问模式。这样普通用户就没有权限用“find”命令来查询这些目 录或者文件。当普通用户使用“find”命令来查询这些文件目录是，往往会出现"Permissiondenied."（禁止访问）字样。系统将无法查询 到你想要的文件。为了避免这样的错误，我们可是使用转移错误提示的方法尝试着查找文件，输入 
find / -name access_log 2> /dev/null 

这个方法是把查找错误提示转移到特定的目录中去。系统执行这个命令后，遇到错误的信息就直接输送到stderrstream 2 中，access_log 2就是表明系统将把错误信息输送到stderrstream 2中，/dev/null是一个特殊的文件，表明空的或者错误的信息，这样查询到的错误信息将被转移了，不会再显示了。 

在Linux系统查找文件也会遇到这样一个实际问题。如果我们在整个硬盘，这个系统中查找某个文件就要花费相当长的一段时间，特别是大型Linux系统和 容量较大的硬盘，文件放在套嵌很深的目录中的时候。如果我们知道了这个文件存放在某个大的目录中，那么只要在这个目录中往下找就能节省很多时间了。使用 find /etc -name httpd.conf 就可以解决这个问题。上面的命令就是表示在etc目录中查询httpd.conf这个文件。这里再说明一下“/ ”这个函数符号的含义，如果输入 “find / ”就是表示要求Linux系统在整个ROOT目录下查找文件，也就是在整个硬盘上查找文件，而“find /etc”就是只在 etc目录下查找文件。因为“find /etc”表示只在etc目录下查找文件，所以查找的速度就相应要快很多了。 

根据部分文件名查找方法： 
这个方法和在WINDOWS中查找已知的文件名方法是一样的。不过在Linux中根据部分文件名查找文件的方法要比在WINDOWS中的同类查找方法要强 大得多。例如我们知道某个文件包含有srm这3个字母，那么要找到系统中所有包含有这3个字母的文件是可以实现的，输入： 
find /etc -name '*srm*' 

这个命令表明了Linux系统将在/etc整个目录中查找所有的包含有srm这3个字母的文件，比如 absrmyz， tibc.srm等等符合条件的文件都能显示出来。如果你还知道这个文件是由srm 这3个字母打头的，那么我们还可以省略最前面的星号，命令如下： 
find /etc -name 'srm*' 

这是只有像srmyz 这样的文件才被查找出来，象absrmyz或者 absrm这样的文件都不符合要求，不被显示，这样查找文件的效率和可靠性就大大增强了。 

根据文件的特征查询方法： 
如果只知道某个文件的大小，修改日期等特征也可以使用“find”命令查找出来，这和WINDOWS系统中的"搜索"功能是基本相同的。在微软的"搜索" 中WINDOWS中的"搜索助理"使得搜索文件和文件夹、打印机、用户以及网络中的其他计算机更加容易。它甚至使在Internet 上搜索更加容易。"搜索助理"还包括一个索引服务，该服务维护了计算机中所有文件的索引，使得搜索速度更快。使用"搜索助理"时，用户可以指定多个搜索标准。例如，用户可以按名称、类型及大小搜索文件和文件夹。用户甚至可以搜索包含特定文本的文件。如果用户正使用 Active Directory，这时还可以搜索带有特定名称或位置的打印机。 

例如我们知道一个Linux文件大小为1,500 bytes，那么我们可是使用如下命令来查询find / -size 1500c，字符 c 表明这个要查找的文件的大小是以bytes为单位。如果我们连这个文件的具体大小都不知道，那么在Linux中还可以进行模糊查找方式来解决。例如我们输 入find/ -size +10000000c这个命令，则标明我们指定系统在根目录中查找出大于10000000字节的文件并显示出来。命令中的“＋”是表示要求系统只列出大于指定大小的文件，而使 用“-”则表示要求系统列出小于指定大小的文件。下面的列表就是在Linux使用不同“ find"命令后系统所要作出的查找动作，从中我们很容易看出在Linux中使用“find"命令的方式是很多的，“ find"命令查找文件只要灵活应用，丝毫不必在WINDOWS中查找能力差。 

find / -amin -10 # 查找在系统中最后10分钟访问的文件 
find / -atime -2 # 查找在系统中最后48小时访问的文件 
find / -empty # 查找在系统中为空的文件或者文件夹 
find / -group cat # 查找在系统中属于 groupcat的文件 
find / -mmin -5 # 查找在系统中最后5分钟里修改过的文件 
find / -mtime -1 #查找在系统中最后24小时里修改过的文件 
find / -nouser #查找在系统中属于作废用户的文件 
find / -user fred #查找在系统中属于FRED这个用户的文件 


下面的列表就是对find命令所可以指定文件的特征进行查找的部分条件。在这里并没有列举所有的查找条件，参考有关Linux有关书籍可以知道所有find命令的查找函数。 
-amin n 
查找系统中最后N分钟访问的文件 
-atime n 
查找系统中最后n*24小时访问的文件 
-cmin n 
查找系统中最后N分钟被改变状态的文件 
-ctime n 
查找系统中最后n*24小时被改变状态的文件 
-empty 
查找系统中空白的文件，或空白的文件目录，或目录中没有子目录的文件夹 
-false 
查找系统中总是错误的文件 
-fstype type 
查找系统中存在于指定文件系统的文件，例如：ext2
-gid n 
查找系统中文件数字组 ID 为n的文件
-group kashu
查找系统中文件属于kashu文件组，并且指定组和ID的文件 


find命令的控制选项说明： 
find命令也提供给用户一些特有的选项来控制查找操作。下表就是我们总结出的最基本，最常用的find命令的控制选项及其用法。 
选项 
用途描述 
-daystart 
.测试系统从今天开始24小时以内的文件，用法类似-amin 
-depth 
使用深度级别的查找过程方式,在某层指定目录中优先查找文件内容 
-follow 
遵循通配符链接方式查找; 另外，也可忽略通配符链接方式查询 
-help 
显示命令摘要 
-maxdepth levels 
在某个层次的目录中按照递减方法查找 
-mount 
不在文件系统目录中查找， 用法类似 -xdev. 
-noleaf 
禁止在非UNUX文件系统，MS-DOS系统，CD-ROM文件系统中进行最优化查找 
-version 
打印版本数字 


使用-follow选项后，find命令则遵循通配符链接方式进行查找，除非你指定这个选项，否则一般情况下find命令将忽略通配符链接方式进行文件查找。 

-maxdepth选项的作用就是限制find命令在目录中按照递减方式查找文件的时候搜索文件超过某个级别或者搜索过多的目录，这样导致查找速度变慢，查找花费的时间过多。例如，我们要在当前(.)目录技巧子目录中查找一个名叫fred的文件，我们可以使用如下命令 
find . -maxdepth 2 -name fred 

假如这个fred文件在./sub1/fred目录中，那么这个命令就会直接定位这个文件，查找很容易成功。假如，这个文件在. /sub1/sub2/fred目录中，那么这个命令就无法查找到。因为前面已经给find命令在目录中最大的查询目录级别为2，只能查找2层目录下的文 件。这样做的目的就是为了让find命令更加精确的定位文件，如果你已经知道了某个文件大概所在的文件目录级数，那么加入-maxdepth n 就很快的能在指定目录中查找成功。 

使用混合查找方式查找文件 
find命令可以使用混合查找的方法，例如我们想在/tmp目录中查找大于100000000字节并且在48小时内修改的某个文件，我们可以使用-and 来把两个查找选项链接起来组合成一个混合的查找方式。 
find /tmp -size +10000000c -and -mtime +2 

学习过计算机语言的朋友都知道，在计算机语言里，使用and ,or 分别表示“与”和“或”的关系。在Linux系统的查找命令中一样通用。 
还有这样的例子， 
find / -user fred -or -user kashu

我们可以解释为在/tmp目录中查找属于fred或者kashu这两个用户的文件。 
在find命令中还可以使用“非”的关系来查找文件，如果我们要在/tmp目录中查找所有不属于panda的文件，使用一个简单的 
find /tmp ! -user panda 
命令就可以解决了。很简单。 

查找并显示文件的方法 
查找到某个文件是我们的目的，我们更想知道查找到的文件的详细信息和属性，如果我们采取现查找文件，在使用ls命令来查看文件信息是相当繁琐的，现在我们也可以把这两个命令结合起来使用。 
find / -name "httpd.conf" -ls 

系统查找到httpd.conf文件后立即在屏幕上显示httpd.conf文件信息。 
12063 34 -rw-r--r-- 1 root root 33545 Dec 30 15:36 /etc/httpd/conf/httpd.conf 

下面的表格就是一些常用的查找文件并显示文件信息的参数和使用方法 
选项 
用途描述 
-exec command
查找并执行命令 
-fprint file
打印文件完整文件名 
-fprint0 file
打印文件完整文件名包括空的文件
-fprintf file format
打印文件格式 
-ok command
给用户命令执行操作，根据用户的Y 确认输入执行
-printf format
打印文件格式 
-ls 
打印同种文件格式的文件

在书写匹配条件时，还可以是使用了逻辑运算符与、或、非组成的复合条件。

与-and    或-or    非!

逻辑运算符的优先级是非、与、或。为了改变这种优先次序可以使用(),建议在()之前使用转移字符，即(写成(,)写成)。

附加示例：
find / -maxdepth 6 -name test -group root(在根下查找，并在6个目录数内以文件名查找属于root组的叫test的文件)
find /home -maxdepth 3 -user linux -or -group kashu(与)
find /home -maxdepth 3 -user linux -and -group kashu(或)
find /home -maxdepth 3 ! -user kashu ! -user linux(非)
find /home -user kashu -exec ls -l {} ;(找出/home目录下所有属于kashu用户的文件并以长模式显示)
find /home -user kashu -exec chmod 777 {} ;(找出/home目录下所有属于kashu用户的文件并更改权限为777)
find /tmp -maxdepth 4 -exec chown :root {} ;(以/tmp目录为基准,找出该目录下4层目录深度内的所有文件后更改文件的属组为root)
find /var/named -exec mv {} /tmp/find ;(将在/var/named下找到的所有文件复制到/tmp/find目录里)

find / (-type d -a -user kashu ) -exec rm -rf {} ;(找出/目录下所有属于kashu用户的目录并强制删除*慎用*)

find . -name 'tmp' -o -name '*.log'(从当前目录开始查询文件名为'tmp'或是匹配'*.log'的所有文件)

find命令练习：
1、找出/etc/底下，文件大小介于50K到60K之间的文件，且将权限完整地列出
-bash-3.00# find /etc -size +50k -a -size -60k -type f -exec ls -AFlh {} \; 2> /dev/null | less
-rw-r--r--  1 root root 57K Oct  9  2009 /etc/hotplug/usb.usermap
......
-rwxr-xr-x  1 root root 57K Feb 28  2012 /etc/mail/sendmail.cf*

2、找出具有SUID的文件有哪些？
-bash-3.00# find / -perm +4000 -exec ls -AFlh {} \; 2> /dev/null | less
-rwsr-xr-x  1 root root 6.1K Jul 13  2005 /usr/bin/kpac_dhcp_helper*
......
-rwsr-xr-x  1 root root 12K Jul 19  2005 /bin/traceroute6*

3、找出/home下大于5M且文件所属用户不是root的文件，并详细列出
-bash-3.00# find /home -size +5M ! -user root -exec ls -AFlh {} \; 2> /dev/null | less
-rw-r--r--  1 mysql mysql 27M Oct 23 05:40 /home/backup/daily/DB_Radius.20121023
......
-rw-r--r--  1 mysql mysql 47M Sep 21 21:25 /home/backup/DB_Radius.20120921

4、找出/root下等于0字节或大于1GB的文件，并详细列出
find /root -size 0 -or -size +1G | xargs ls -AFlhS 2> /dev/null






linux find 命令忽略某个或多个子目录的方法

在linux find 进行查找的时候，有时候需要忽略某些目录不查找，可以使用 -prune 参数来进行过滤，但必须要注意要忽略的路径参数必须紧跟着搜索的路径之后，否则该参数无法起作用。

以下是指定搜索/home/carryf目录下的所有文件，但是会忽略/home/carryf/astetc的路径：
find /home/carryf -path "/home/carryf/astetc" -prune -o -type f -print

如果按照文件名来搜索则为：
find /home/carryf -path "/home/carryf/astetc" -prune -o -type f -name "cdr_*.conf" -print

如果要忽略两个以上的路径如何处理？
find /home/carryf /( -path "/home/carryf/astetc" -o -path "/home/carryf/etc" /) -prune -o -type f  -print
find /home/carryf /( -path "/home/carryf/astetc" -o -path "/home/carryf/etc" /) -prune -o -type f  -name "cdr_*.conf" -print

++++++++++++++++注意/( 和/) 前后一定要有空格++++++++++++++++

批量复制find命令所找到的文件到另外的目录中
find $PWD \( -iname "*.ssa" -o -iname "*.ass" -o -iname "*.srt" \) -exec cp {} /tmp/subtitle_files/ \;
find $PWD \( -iname "*.ssa" -o -iname "*.ass" -o -iname "*.srt" \) -print0 | xargs -0 enca -L zh_cn | less
把所有字幕文件的编码格式转换成utf-8的格式
find $PWD \( -iname "*.ssa" -o -iname "*.ass" -o -iname "*.srt" \) -print0 | xargs -0 enca -L zh_cn -x utf-8

把系统中所有SUID和SGID为root用户的文件搜索出来，并全部剔除此特殊权限
find / -path "/proc" -prune -o -perm +4000 -user root -type f -exec chmod u-s {} \;
find / -path "/proc" -prune -o -perm +2000 -group root -type f -exec chmod g-s {} \;




默认情况下, find 每输出一个文件名, 后面都会接着输出一个换行符 ('\n'), 因此我们看到的 find 的输出都是一行一行的:
kashu@ubuntu:~$ ls -l
total 0
-rw-r--r-- 1 root root 0 2010-08-02 18:09 file1.log
-rw-r--r-- 1 root root 0 2010-08-02 18:09 file2.log
 
kashu@ubuntu:~$ find -name '*.log'
./file2.log
./file1.log
 
比如我想把所有的 .log 文件删掉, 可以这样配合 xargs 一起用:
kashu@ubuntu:~$ find -name '*.log'
./file2.log
./file1.log
kashu@ubuntu:~$ find -name '*.log' | xargs rm
kashu@ubuntu:~$ find -name '*.log'
 
嗯, 不错, find+xargs 真的很强大. 然而:
kashu@ubuntu:~$ ls -l
total 0
-rw-r--r-- 1 root root 0 2010-08-02 18:12 file 1.log
-rw-r--r-- 1 root root 0 2010-08-02 18:12 file 2.log
kashu@ubuntu:~$ find -name '*.log'
./file 1.log
./file 2.log
kashu@ubuntu:~$ find -name '*.log' | xargs rm
rm: cannot remove `./file': No such file or directory
rm: cannot remove `1.log': No such file or directory
rm: cannot remove `./file': No such file or directory
rm: cannot remove `2.log': No such file or directory
 
原因其实很简单, xargs 默认是以空白字符 (空格, TAB, 换行符) 来分割记录的, 因此文件名 ./file 1.log 被解释成了两个记录 ./file 和 1.log, 不幸的是 rm 找不到这两个文件.
 
为了解决此类问题, 聪明的人想出了一个办法, 让 find 在打印出一个文件名之后接着输出一个 NULL 字符 ('\0') 而不是换行符, 然后再告诉 xargs 也用 NULL 字符来作为记录的分隔符. 这就是 find 的 -print0 和 xargs 的 -0 的来历吧.
kashu@ubuntu:~$ ls -l
total 0
-rw-r--r-- 1 root root 0 2010-08-02 18:12 file 1.log
-rw-r--r-- 1 root root 0 2010-08-02 18:12 file 2.log
kashu@ubuntu:~$ find -name '*.log' -print0 | hd
           0  1  2  3   4  5  6  7   8  9  A  B   C  D  E  F  |0123456789ABCDEF|
--------+--+--+--+--+---+--+--+--+---+--+--+--+---+--+--+--+--+----------------|
00000000: 2e 2f 66 69  6c 65 20 31  2e 6c 6f 67  00 2e 2f 66  |./file 1.log../f|
00000010: 69 6c 65 20  32 2e 6c 6f  67 00                     |ile 2.log.      |
kashu@ubuntu:~$ find -name '*.log' -print0 | xargs -0 rm
kashu@ubuntu:~$ find -name '*.log'
 
你可能要问了, 为什么要选 '\0' 而不是其他字符做分隔符呢? 这个也容易理解: 一般的编程语言中都用 '\0' 来作为字符串的结束标志, 文件的路径名中不可能包含 '\0' 字符.

以上转自：http://blog.163.com/laser_meng@126/blog/static/16972784420117102638257/
 
 
其他我收集的find、xargs实例：
 
删除以html结尾的10天前的文件，包括带空格的文件：
find /usr/local/backups -name "*.html" -mtime +10 -print0 |xargs -0 rm -rfv
find /usr/local/backups -mtime +10 -name "*.html" -exec rm -rf {} \;
 
find -print 和 -print0的区别:
-print 在每一个输出后会添加一个回车换行符，而-print0则不会。
 
当前目录下文件从大到小排序（包括隐藏文件），文件名不为"."：
find . -maxdepth 1 ! -name "." -print0 | xargs -0 du -b | sort -nr | head -10 | nl
nl：可以为输出列加上编号,与cat -n相似，但空行不编号
 
以下功能同上，但不包括隐藏文件：
for file in *; do du -b "$file"; done|sort -nr|head -10|nl
 
xargs结合sed替换：
find . -name "*.txt" -print0 | xargs -0 sed -i 's/aaa/bbb/g'
 
xargs结合grep：
find . -name '*.txt' -type f -print0 |xargs -0 grep -n 'aaa'    #“-n”输出行号
