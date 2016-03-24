下载LOFTER客户端
chkconfig

功能说明：检查、设定系统的各种服务。

语法：chkconfig [--add][--del][--list][系统服务]或
chkconfig [--level<等级代号>][系统服务][on/off/reset]

补充说明:这个是redhat公司遵循gpl规则所开发的程序,它可以查询操作系统在每一个执行等级(runlevel)中,会执行哪些系统服务，其中包括各种daemon。

linux os 将操作环境分为以下7个等级:


0:开机(请不要切换到此等级)
1:单人使用者模式的文字界面
2:多人使用者模式的文字界面,不具有网络档案系统(NFS)功能
3:多人使用者模式的文字界面,具有网络档案系统(NFS)功能
4:某些发行版的linux使用此等级进入x windows system
5:某些发行版的linux使用此等级进入x windows system
6:重新启动

参数:--add   新增所指定的系统服务
        --del 删除所指定的系统服务
        --level 指定该系统服务要在哪个执行等级中开启或关闭
        --list   列出当前可从chkconfig指令管理的所有系统服务和等级代号
            on/off/reset   在指定的执行登记,开启/关闭/重置该系统服务

chkconfig命令主要用来更新（启动或停止）和查询系统服务的运行级信息。谨记chkconfig不是立即自动禁止或激活一个服务，它只是简单的改变了符号连接。

语法：

    chkconfig --list [name]
    chkconfig --add name
    chkconfig --del name
    chkconfig [--level levels] name <on|off|reset>
    chkconfig [--level levels] name

    chkconfig 没有参数运行时，显示用法。如果加上服务名，那么就检查这个服务是否在当前运行级启动。如果是，返回true，否则返回false。如果在服务名后面指定 了on，off或者reset，那么chkconfi 会改变指定服务的启动信息。on和off分别指服务被启动和停止，reset指重置服务的启动信息，无论有问题的初始化脚本指定了什么。on和off开 关，系统默认只对运行级3，4，5有效，但是reset可以对所有运行级有效。

    --level选项可以指定要查看的运行级而不一定是当前运行级。

    需要说明的是，对于每个运行级，只能有一个启动脚本或者停止脚本。当切换运行级时，init不会重新启动已经启动的服务，也不会再次去停止已经停止的服务。

    chkconfig --list ：显示所有运行级系统服务的运行状态信息（on或off）。如果指定了name，那么只显示指定的服务在不同运行级的状态。

    chkconfig --add name：增加一项新的服务。chkconfig确保每个运行级有一项启动(S)或者杀死(K)入口。如有缺少，则会从缺省的init脚本自动建立。

    chkconfig --del name：删除服务，并把相关符号连接从/etc/rc[0-6].d删除。

    chkconfig [--level levels] name <on|off|reset>：设置某一服务在指定的运行级是被启动，停止还是重置。例如，要在3，4，5运行级停止nfs服务，则命令如下：

    chkconfig --level 345 nfs off

运行级文件：

    每个被chkconfig管理的服务需要在对应的init.d下的脚本加上两行或者更多行的注释。第一行告诉chkconfig缺省启动的运行级以及启动 和停止的优先级。如果某服务缺省不在任何运行级启动，那么使用 - 代替运行级。第二行对服务进行描述，可以用\ 跨行注释。
例如，random.init包含三行：
# chkconfig: 2345 20 80
# description: Saves and restores system entropy pool for \
# higher quality random number generation.

附加介绍一下Linux系统的运行级的概念：
    Linux中有多种运行级，常见的就是多用户的2，3，4，5 ，很多人知道5是运行X-Windows的级别，而0就是关机了。运行级的改变可以通过init命令来切换。例如，假设你要维护系统进入单用户状态，那 么，可以使用init1来切换。在Linux的运行级的切换过程中，系统会自动寻找对应运行级的目录/etc/rc[0-6].d下的K和S开头的文件， 按后面的数字顺序，执行这些脚本。对这些脚本的维护，是很繁琐的一件事情，Linux提供了chkconfig命令用来更新和查询不同运行级上的系统服 务。

范例:

1.查看在各种不同的执行等级中,各项服务的状况:
$chkconfig --list

2.列出系统服务vsftpd在各个执行等级的启动情况：
$chkconfig --list vsftpd

3.在执行等级3,5时，关闭vsftpd系统服务：
$chkconfig --level 35 vsftpd off

4.在执行等级2，3，5时，开启 vsftpd系统服务：
$chkconfig --level 235 vsftpd on

5.关闭一些自己不需要的服务 ->
如果没有打印机：
chkconfig --level 235 cups off 
如果没有局域网：
chkconfig --level 235 smb off
如果不需要远程用户登录的：
chkconfig --level 235 sshd off
如果不需要定时任务的：
chkconfig --level 235 crond off
如果不需要添加新硬件的：
chkconfig --level 235 kudzu off
