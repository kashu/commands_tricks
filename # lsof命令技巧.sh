Lsof（LiSt Opened Files）是遵从Unix哲学的典范，它只做一件事情，并且做的相当完美——它可以列出某个进程打开的所有文件信息。打开的文件可能是普通的文件，目录，NFS文件，块文件，字符文件，共享库，常规管道，命名管道，符号链接，Socket流，网络Socket，UNIX域Socket，以及其它更多。因为Unix系统中几乎所有东西都是文件，你可以想象lsof该有多有用。

-u 用户名或UID
-c 进程名
-p 进程ID
-i [46][protocol][@hostname|hostaddr][:service|port]
-P 不解析端口名
-n 不解析主机名
-r 重复模式（repeat mode）
-a AND
^  忽略（不包含，exclude）
-s 显示文件大小（单位：字节）
-h -? 帮助信息

查看所有进程打开的所有文件（通常需要root权限）
#lsof

查看谁在用某个目录或文件
#lsof /proc
#lsof /proc /tmp

查看某个或多个用户打开的所有文件
#lsof -u root
#lsof -uroot,kashu

查看 除了 某个或多个用户以外的所有用户所打开的所有文件
#lsof -u ^root
#lsof -u^root,^kashu

-c选项限定只列出以a 开头的进程 打开的文件
#lsof -c a
#lsof -ctop -cinit
echo `lsof -c /chromium-browse/ -t`

查看所有由某个用户 或 某个进程打开的文件
#lsof -uroot -ca

查看所有由个用户 与 某个进程打开的文件
#lsof -a -uroot -ca
#lsof -auroot -ca

查看所有由某个PID对应的进程打开的文件
#lsof -p1
#lsof -p1,10,15
#lsof -p`pidof fcitx`
查看除了PID是1,10,15以外的进程所打开的文件
#lsof -p^1,10,15
查看kashu用户中所有除了PID为2910和2911以外的所有进程所打开的文件
#lsof -aukashu -p^2910,^2911 | less

lsof的-i选项列出所有打开了网络套接字（TCP和UDP）的进程。
#lsof -i
列出所有TCP网络连接
#lsof -itcp
列出所有UDP网络连接
#lsof -iudp

列出占用TCP或UDP的80或443端口的进程
#lsof -i:80
#lsof -i:http
#lsof -i:80,443
#lsof -i:80,https

列出使用了某个tcp或udp端口的进程
#lsof -i tcp:443
#lsof -i tcp:https
#lsof -i udp:53,69

查看kashu用户打开的所有套接字文件（即：查看某个用户的所有网络连接）
#lsof -aukashu -i




查看所有NFS（网络文件系统）文件
#lsof -N

查看所有UNIX域Socket文件
#lsof -U

列出使用某些资源的进程pid
#lsof -ti








这个选项也很好记，-U就对应UNIX。

列出所有对应某个组id的进程

# lsof -g 1234

进程组用来来逻辑上对进程进行分组，这个例子查找所有PGID为1234的进程打开的文件。

列出所有与某个描述符关联的文件

# lsof -d 2

这个命令会列出所有以描述符2打开的文件。

你也可以为描述符指定一个范围：

# lsof -d 0-2

这会列出所有描述符为0，1，2的文件。

-d选项还支持其它很多特殊值，下面的命令列出所有内存映射文件：

# lsof -d mem

txt则列出所有加载在内存中并正在执行的进程：

# lsof -d txt



-t选项输出进程的PID，你可以将它和-i选项组合输出使用某个端口的进程的PID，下面的命令将会杀掉所有使用网络的进程：

# kill -9 `lsof -t -i`

循环列出文件

# lsof -r 1

-r选项让lsof可以循环列出文件直到被中断，参数1的意思是每秒钟重复打印一次，这个选项最好同某个范围比较小的查询组合使用，比如用来监测网络活动：

# lsof -r 1 -u john -i -a

如何安装lsof？

许多Unix系统都内置了lsof，如果你的系统没有安装，你可以从这里直接下载源代码。

BSD系统有一个类似的工具可以做同样的事情，叫做fstat。











This is the third post in the article series about Unix and Linux utilities that you should know about. In this post I will take you through the useful lsof tool. If netcat was called the Swiss Army Knife of Network Connections, then I'd call lsof the Swiss Army Knife of Unix debugging.

Lsof follows Unix philosophy closely. It does just one task and it does it perfectly -- it lists information about files opened by processes. An open file may be a regular file, a directory, a NFS file, a block special file, a character special file, a shared library, a regular pipe, a named pipe, a symbolic link, a socket stream, an Internet socket, a UNIX domain socket, and many others. Since almost everything in Unix is a file, you can imagine how incredibly useful lsof is!

See the first post on pipe viewer for the introduction to this article series. If you are interested in articles like this one, I suggest that you subscribe to my rss feed to receive my future posts automatically!

How to use lsof?

In this article I will try to present lsof based on as many use cases as I can think of. Let's start with the simplest (that you probably already know) and proceed to more complicated ones.

List all open files.

# lsof
Running lsof without any arguments lists all open files by all processes.

Find who's using a file.

# lsof /path/to/file
With an argument of a path to a file, lsof lists all the processes, which are using the file in some way.

You may also specify several files, which lists all the processes, which are using all the files:

# lsof /path/to/file1 /path/to/file2
Find all open files in a directory recursively.

# lsof +D /usr/lib
With the +D argument lsof finds all files in the specified directory and all the subdirectories.

Note that it's slower than the usual version with grep:

# lsof | grep '/usr/lib'
It's slower because +D first finds all the files and only then does the output.

List all open files by a user.

# lsof -u pkrumins
The -u option (think user) limits output of files opened only by user pkrumins.

You can use comma separated list of values to list files open by several users:

# lsof -u rms,root
This will list all the files that are open by users rms and root.

Another way to do the same is by using the -u option twice:

# lsof -u rms -u root
Find all open files by program's name.

# lsof -c apache
The -c option selects the listing of files for processes whose name begins with apache.

So instead of writing:

# lsof | grep foo
You can now write the shorter version:

# lsof -c foo
In fact, you can specify just the beginning part of the process name you're looking for:

# lsof -c apa
This will list all the open files by a processes whose starts with apa.

You can also specify several -c options to output open files by several processes:

# lsof -c apache -c python
This will list all open files by apache and python.

List all open files by a user OR process.

# lsof -u pkrumins -c apache
Lsof options can be combined. The default is to OR between options. It means it will combine outputs of -u pkruminsand -c apache producing a listing of all open files by pkrumins and all open files by apache.

List all open files by a user AND process.

# lsof -a -u pkrumins -c bash
Notice the -a option. It combines the options with AND. The output listing is files opened by bash, which is run underpkrumins user.

List all open files by all users EXCEPT root.

# lsof -u ^root
Notice the ^ character before root username. It negates the match and causes lsof print all open files by all users who are not root.

List all open files by the process with PID.

# lsof -p 1
The -p option (think PID) filters out open files by program's id.

Remember that you can select multiple PIDs by either comma separating the list or using multiple -p arguments:

# lsof -p 450,980,333
This selects processes with PIDs 450, 980 and 333.

List all open files by all the processes EXCEPT process with PID.

# lsof -p ^1
Here the negation operator ^ is used again. It inverts the list and does not include process with PID 1.

List all network connections.

# lsof -i
Lsof with -i option lists all processes with open Internet sockets (TCP and UDP).

List all TCP network connections.

# lsof -i tcp
The -i argument can take several options, one of them is tcp. The tcp option forces lsof to list only processes with TCP sockets.

List all UDP network connections.

# lsof -i udp
The udp option causes lsof to list processes with UDP sockets.

Find who's using a port.

# lsof -i :25
The :25 option to -i makes lsof find processes using TCP or UDP port 25.

You may also use service port name (found in /etc/services) rather than port number:

# lsof -i :smtp
Find who's using a specific UDP port.

# lsof -i udp:53
Similarly, to find who's using a TCP port, use:

# lsof -i tcp:80
Find all network activity by user.

# lsof -a -u hacker -i
Here the -a option combines -u and -i to produce listing of network file usage by user hacker.

List all NFS (Network File System) files.

# lsof -N
This option is easy to remember because -N is NFS.

List all Unix domain socket files.

# lsof -U
This option is also easy to remember because -U is Unix.

List all files for processes with a specific group id.

# lsof -g 1234
Process groups are used to logically group processes. This example finds all files opened by processes with PGID 1234.

List all files associated with specific file descriptors.

# lsof -d 2
This lists all files that have been opened as file descriptor 2.

You may also specify ranges of file descriptors:

# lsof -d 0-2
This would list all files with file descriptors 0, 1 and 2.

There are also many special values, such as mem, that lists memory-mapped files:

# lsof -d mem
Or txt for programs loaded in memory and executing:

# lsof -d txt
Output PIDs of processes using some resource.

# lsof -t -i
The -t option outputs only PIDs of processes. Used together with -i it outputs PIDs of all processes with network connections. It's easy to kill all processes that use network:

# kill -9 `lsof -t -i`
Repeat listing files.

# lsof -r 1
The -r option makes lsof repeatedly list files until interrupted. Argument 1 means repeat the listing every 1 second. This option is best combined with a narrower query such as monitoring user network file activity:

# lsof -r 1 -u john -i -a
How to install lsof?

Lsof comes preinstalled on many Unix systems. If your system doesn't have it, try to install it from the source.

BSD supplies its own utility that does similar things, it's called fstat.

For the full documentation of lsof see the man lsof page or type lsof -h for a small cheat sheet.
