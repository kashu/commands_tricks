CentOS 中yum的使用
一. yum是什么
yum = Yellow dog Updater, Modified
主要功能是更方便的添加/删除/更新RPM包.
它能自动解决包的依赖性问题.
它能便于管理大量系统的更新问题
注:为什么要使用yum而不用apt,最简单的原因CentOS自带

二. yum特点
*可以同时配置多个资源库(Repository)
*简洁的配置文件(/etc/yum.conf，/etc/yum.repos.d 下的文件)
*自动解决增加或删除rpm包时遇到的依赖性问题
*使用方便
*保持与RPM数据库的一致性

三. yum安装
CentOS自带
#rpm -ivh yum-2.4.3-4.el4.centos.noarch.rpm

四. yum配置
注:修改和增加配置文件中的资源库,加快下载速度和拥有更多可更新的rpm包
将/etc/yum.conf的内容改改为
[main]
cachedir=/var/cache/yum
//这是缓存目录地址
debuglevel=2 //调试级别,建议默认，不然install时，会好多error
logfile=/var/log/yum.log //日志文件的位置,install 时，看这里就知道发生了什么
pkgpolicy=newest
#installonlypkgs=kernel kernel-smp kernel-devel kernel-smp-devel kernel-largesmp kernel-largesmp-devel kernel-hugemem kernel-hugemem-devel
//注销这一行的是不只更新kernel
distroverpkg=centos-release
tolerant=1
exactarch=1 //确定是否在i386上更新i686的软件包,选1的是不更新
retries=20
obsoletes=1
gpgcheck=1
plugins=1
把CentOS-Base.repo （安装yum后已有的），做一下备份
#cp CentOS-Base.repo CentOS-Base.repo.default
在清空整个CentOS-Base.repo 文件的内容。增加如下内容
文件内容在下面的包中。
启动yum
#service yum start
#chkconfig yum on
在导入上面来个站点的KEY
rpm --import http://ftp.hostrino.com/pub/centos/RPM-GPG-KEY-CentOS-4
rpm --import http://mirror.be10.com/centos/RPM-GPG-KEY-CentOS-4
rpm --import http://ftp.daum.net/centos/RPM-GPG-KEY-CentOS-4
rpm --import http://centos.ustc.edu.cn/centos/RPM-GPG-KEY-CentOS-4
rpm --import http://mirror.tini4u.net/centos/RPM-GPG-KEY-CentOS-4
扩展你的rpm包
wget http://apt.sw.be/redhat/el4/en/i386/RPMS.dag/rpmforge-release-0.3.6-1.el4.rf.i386.rpm
安装 rpmforge-release-0.3.6-1.el4.rf.i386.rpm
# rpm -ivh rpmforge-release-0.3.6-1.el4.rf.i386.rpm
# rpm --import http://dag.wieers.com/rpm/packages/RPM-GPG-KEY.dag.txt
在 /etc/yum.repos.d 下将产生这样两个文件
mirrors-rpmforge
rpmforge.repo
上面红色字的这部分，有待大家一同研究啊，网上这样写的。但我实现不了。

五. yum应用
注:当第一次使用yum或yum资源库有更新时,yum会自动下载所有所需的headers放置于/var/cache/yum目录下,所需时间可能较长.
检查有哪些可更新的rpm包
#yum check-update
安装rpm包,使xmms可以播放mp3
#yum install xmms-mp3
安装mplayer,同时自动安装相关的软件
#yum install mplayer
删除licq包,同时删除与该包有倚赖性的包
#yum remove licq
注:同时会提示删除licq-gnome,licq-qt,licq-text,非常方便
系统更新(更新所有可以升级的rpm包,包括kernel)
#yum -y update
每天定期执行系统更新
#chkconfig yum on
#service yum start

六. yum指令详解
*rpm包的更新
检查可更新的rpm包
#yum check-update
更新所有的rpm包
#yum update
更新指定的rpm包,如更新kernel和kernel source
#yum update kernel kernel-source
大规模的版本升级,与yum update不同的是,连旧的淘汰的包也升级
#yum upgrade
*rpm包的安装和删除
安装rpm包,如xmms-mp3
#yum install xmms-mp3
删除rpm包,包括与该包有倚赖性的包
#yum remove licq
注:同时会提示删除licq-gnome,licq-qt,licq-text
*yum暂存(/var/cache/yum/)的相关参数
清除暂存中rpm包文件
#yum clean packages
清除暂存中rpm头文件
#yum clean headers
清除暂存中旧的rpm头文件
#yum clean oldheaders
清除暂存中旧的rpm头文件和包文件
#yum clean 或#yum clean all
注:相当于yum clean packages + yum clean oldheaders
*rpm包列表
列出资源库中所有可以安装或更新的rpm包
#yum list
列出资源库中特定的可以安装或更新以及已经安装的rpm包
#yum list mozilla
#yum list mozilla*
注:可以在rpm包名中使用匹配符,如列出所有以mozilla开头的rpm包
列出资源库中所有可以更新的rpm包
#yum list updates
列出已经安装的所有的rpm包
#yum list installed
列出已经安装的但是不包含在资源库中的rpm包
#yum list extras
注:通过其它网站下载安装的rpm包
*rpm包信息显示(info参数同list)
列出资源库中所有可以安装或更新的rpm包的信息
#yum info
列出资源库中特定的可以安装或更新以及已经安装的rpm包的信息
#yum info mozilla
#yum info mozilla*
注:可以在rpm包名中使用匹配符,如列出所有以mozilla开头的rpm包的信息
列出资源库中所有可以更新的rpm包的信息
#yum info updates
列出已经安装的所有的rpm包的信息
#yum info installed
列出已经安装的但是不包含在资源库中的rpm包的信息
#yum info extras
注:通过其它网站下载安装的rpm包的信息
*搜索rpm包
搜索匹配特定字符的rpm包
#yum search mozilla
注:在rpm包名,包描述等中搜索
搜索有包含特定文件名的rpm包
#yum provides realplay

How do I use yum command to update and patch my Red hat Enterprise Linux / CentOS Linux version 5.x server via RHN / Internet? Can I use up2date command under RHEL 5?

up2date command was part of RHEL v4.x or older version. You need to use yum command to update and patch the system using RHN or Internet. Use yum command to install critical and non-critical security updates as well as binary packages. Login as the root user to install and update the system.

yum命令 - 卡书 - Self-Study
Task: Register my system with RHN

To register your system with RHN type the following command and just follow on screen instructions (CentOS user skip to next step):
# rhn_register

yum命令 - 卡书 - Self-StudyWARNING! These examples only works with RHEL / CentOS Linux version 5.x or above. For RHEL 4.x and older version use up2date command.
Task: Display list of updated software (security fix)

Type the following command at shell prompt:
# yum list updates

Task: Patch up system by applying all updates

To download and install all updates type the following command:
# yum update

Task: List all installed packages

List all installed packages, enter:
# rpm -qa
# yum list installed

Find out if httpd package installed or not, enter:
# rpm -qa | grep httpd*
# yum list installed httpd

Task: Check for and update specified packages

# yum update {package-name-1}

To check for and update httpd package, enter:
# yum update httpd

Task: Search for packages by name

Search httpd and all matching perl packages, enter:
# yum list {package-name}
# yum list {regex}
# yum list httpd
# yum list perl*

Sample output:

Loading "installonlyn" plugin
Loading "security" plugin
Setting up repositories
Reading repository metadata in from local files
Installed Packages
perl.i386                                4:5.8.8-10.el5_0.2     installed
perl-Archive-Tar.noarch                  1.30-1.fc6             installed
perl-BSD-Resource.i386                   1.28-1.fc6.1           installed
perl-Compress-Zlib.i386                  1.42-1.fc6             installed
perl-DBD-MySQL.i386                      3.0007-1.fc6           installed
perl-DBI.i386                            1.52-1.fc6             installed
perl-Digest-HMAC.noarch                  1.01-15                installed
perl-Digest-SHA1.i386                    2.11-1.2.1             installed
perl-HTML-Parser.i386                    3.55-1.fc6             installed
.....
.......
..
perl-libxml-perl.noarch                  0.08-1.2.1             base
perl-suidperl.i386                       4:5.8.8-10.el5_0.2     updates 
Task: Install the specified packages [ RPM(s) ]

Install package called httpd:
# yum install {package-name-1} {package-name-2}
# yum install httpd

Task: Remove / Uninstall the specified packages [ RPM(s) ]

Remove package called httpd, enter:
# yum remove {package-name-1} {package-name-2}
# yum remove httpd

Task: Display the list of available packages

# yum list all

Task: Display list of group software

Type the following command:
# yum grouplist

Output:

Installed Groups:
   Engineering and Scientific
   MySQL Database
   Editors
   System Tools
   Text-based Internet
   Legacy Network Server
   DNS Name Server
   Dialup Networking Support
   FTP Server
   Network Servers
   Legacy Software Development
   Legacy Software Support
   Development Libraries
   Graphics
   Web Server
   Ruby
   Printing Support
   Mail Server
   Server Configuration Tools
   PostgreSQL Database
Available Groups:
   Office/Productivity
   Administration Tools
   Beagle
   Development Tools
   GNOME Software Development
   X Software Development
   Virtualization
   GNOME Desktop Environment
   Authoring and Publishing
   Mono
   Games and Entertainment
   XFCE-4.4
   Tomboy
   Java
   Java Development
   Emacs
   X Window System
   Windows File Server
   KDE Software Development
   KDE (K Desktop Environment)
   Horde
   Sound and Video
   FreeNX and NX
   News Server
   Yum Utilities
   Graphical Internet
Done
Task: Install all the default packages by group

Install all 'Development Tools' group packages, enter:
# yum groupinstall "Development Tools"

Task: Update all the default packages by group

Update all 'Development Tools' group packages, enter:
# yum groupupdate "Development Tools"

Task: Remove all packages in a group

Remove all 'Development Tools' group packages, enter:
# yum groupremove "Development Tools"

Task: Install particular architecture package

If you are using 64 bit RHEL version it is possible to install 32 packages:
# yum install {package-name}.{architecture}
# yum install mysql.i386

Task: Display packages not installed via official RHN subscribed repos

Show all packages not available via subscribed channels or repositories i.e show packages installed via other repos:
# yum list extras

Sample output:

Loading "installonlyn" plugin
Loading "security" plugin
Setting up repositories
Reading repository metadata in from local files
Extra Packages
DenyHosts.noarch                         2.6-python2.4          installed
VMwareTools.i386                         6532-44356             installed
john.i386                                1.7.0.2-3.el5.rf       installed
kernel.i686                              2.6.18-8.1.15.el5      installed
kernel-devel.i686                        2.6.18-8.1.15.el5      installed
lighttpd.i386                            1.4.18-1.el5.rf        installed
lighttpd-fastcgi.i386                    1.4.18-1.el5.rf        installed
psad.i386                                2.1-1                  installed
rssh.i386                                2.3.2-1.2.el5.rf       installed
Task: Display what package provides the file

You can easily find out what RPM package provides the file. For example find out what provides the /etc/passwd file:
# yum whatprovides /etc/passwd

Sample output:

Loading "installonlyn" plugin
Loading "security" plugin
Setting up repositories
Reading repository metadata in from local files
setup.noarch                             2.5.58-1.el5           base
Matched from:
/etc/passwd
setup.noarch                             2.5.58-1.el5           installed
Matched from:
/etc/passwd
You can use same command to list packages that satisfy dependencies:
# yum whatprovides {dependency-1} {dependency-2}

Refer yum command man page for more information:
# man yum












做为一个RHCA，当然有一些管理yum的小技巧。我原来以为别人都会,后来才发现只有自己知道.好东西当然要分享。 另外,我有一些对生产环境安装软件的朋友一些建议。多用rpm,deb之类的包管理安装，不要使用编译安装。原因有以下几点.

1.编译安装麻烦,浪费时间. 
2.你以后可能都不记的编译的参数，你的下一任维护也麻烦.因为他不清楚你当时是用的什么参数编译.这个你的boss可关心着哦. 
3.当然，有人一定会讲,编译性能高,其实不见的，出问题的机会也高哦,在讲一个程式性能提高3%有什么用。其实没有多少用.当然，你用LFS的系统做生产环境，那就有分别,因为你任何一个包都是自己编译的.相信你不会吧. 
4.rpm -qf 可以查到那个文件是那个包,要是有一天,你的系统中有个文件坏了。你可以用rpm这个方法一下找出一,但你用编译安装，你就头痛了，天啊，这个包是那个软件生成的啊.呵呵. 
5.我不愿意从源程式安装。不是因为难。相反的，蛮容易。只是，我不愿意搞乱我的系统。如果我将从来源安装的程式更新，常常会发生的问题是还有一些档案没有被删除的干净。有时候这种情况会产生问题。如果要删除这个程式，你怎么保证所有被安装的档案都被删除？  尽可能，我宁愿用 RPM 来安装。用 RPM 来更新和删除，RPM 做的很干净。


好了，下面介绍重点:

技巧1:加快你的yum的速度.

使用yum的扩展插件yum-fastestmirror，个人认为这个插件非常有效，速度真的是明显提高，

yum -y install yum-fastestmirror
注意，在Centos 4上,名字叫yum-plugin-fastestmirror

技巧2:扩展你的rpm包

好多包官方没有,怎么搞定他.要我自己编译吗? 好了，你安装这个包,这个是redhat5的哦。这种有三个选择,可以多选.

(1.使用 wieers 的源

你可以自己到 http://dag.wieers.com/rpm/FAQ.php#B 这来找 # Red Hat Enterprise Linux 5 / i386:

rpm -Uhv http://apt.sw.be/redhat/el5/en/i386/rpmforge/RPMS/rpmforge-release-0.3.6-1.el5.rf.i386.rpm
# Red Hat Enterprise Linux 5 / x86_64:

rpm -Uhv http://apt.sw.be/redhat/el5/en/x86_64/rpmforge/RPMS//rpmforge-release-0.3.6-1.el5.rf.x86_64.rpm
(2. 使用 EPEL 的源

这个是EPEL为Fedora类RHEL系统的增强软件包源,也算半官方的源,项目的地址http://fedoraproject.org/wiki/EPEL/FAQ

rpm -ivh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm # 这是 Centos5
(3. 使用 CentALT 的源

这个是为 RHEL 做的增强的源，有最新的如 nginx,mysql 之类

rpm -ihv http://centos.alt.ru/repository/centos/5/i386/centalt-release-5-3.noarch.rpm
(4. ATrpms 的源

这个仓库提供了很多使用最新技术的应用程序和像myth-TV这样的多媒体工具，比如多媒体工具会有一些专利技术在，比如mp3/rmvb解码这样的内容，最开始开始主要是提供一些自然科学方面的软件，尤其是高能物理计算和数值计算工具这样的软件。在加入了很多其他软件以后，这个仓库已经不再是以前那么单一性质的软件仓库了。

仓库链接: http://atrpms.net/

建议使用这个源的稳定stable版本的软件, 如果想试验最新技术，使用bleeding和testing时候自担风险.

查看： http://dl.atrpms.net/el5-i386/atrpms/

安装方法：

首先导入PGP key     

rpm --import http://ATrpms.net/RPM-GPG-KEY.atrpms
然后配置仓库文件，直接建立一个文件，放在/etc/yum.repos.d/目录下，可以命名成atrpms.repo，内容如下：

# Name:ATrpms
# URL: http://atrpms.net/ 
[atrpms] 
name=Fedora Core $releasever - $basearch - ATrpms
baseurl=http://dl.atrpms.net/el5-i386/atrpms/stable/
#baseurl=http://dl.atrpms.net/el5-i386/atrpms/bleeding/
#baseurl=http://dl.atrpms.net/el5-i386/atrpms/testing/
enable=1
protect=0
gpgkey=http://ATrpms.net/RPM-GPG-KEY.atrpms
gpgcheck=1
技巧3:rpm查找.

还是有rpm包找不到怎么办,到下面这个网站。基本上都收集全了，你可以用高级查找看看. http://rpm.pbone.net/

技巧4:通过yum工具下载RPM源码包

前提是有安装 yum-utils这个软件包.如果有安装的话

yumdownloader  --source  RPM源码包
yumdownloader  --source vsftpd
当然,没有源包的话,还要加入一个源

[linux-src]
name=Centos $releasever - $basearch - Source
baseurl=http://mirrors.163.com/centos/$releasever/os/SRPMS/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
技巧5:软件组安装

有时我们安装完系统，管理有一类软件没有安装，比如用于开发的开发包,我们可以用软件组来安装，这是最建议使用的安装软件的方法。

yum grouplist #这样可以列出所有的软件包
比如我们要安装开发有关的包

yum groupinstall "Development Libraries"
yum groupinstall "Development Tools"
技巧6:查询文件和路径是哪个 rpm 包套件

#文件本地存在
rpm -qf $(which ls)   # 文件本地不存在
yum whatprovides */bin/ls
怎么样,上面的方法对你有用吗?
