rdesktop is an open source client for Windows Remote Desktop Services, capable of natively speaking Remote Desktop Protocol (RDP) in order to present the user's Windows desktop. rdesktop is known to work with Windows versions such as NT 4 Terminal Server, 2000, XP, 2003, 2003 R2, Vista, 2008, 7, and 2008 R2.
rdesktop currently runs on most UNIX based platforms with the X Window System, and other ports should be fairly straightforward.

kashu@kashu:~$ sudo apt-get install rdesktop (For Ubuntu)

[root@www.kashu.org ~]# yum install rdesktop (For RHEL/CentOS)

[root@www.kashu.org ~]# yum info rdesktop

Loaded plugins: fastestmirror, product-id, refresh-packagekit, subscription-manager

Updating certificate-based repositories.

Unable to read consumer identity

Loading mirror speeds from cached hostfile

Installed Packages

Name        : rdesktop

Arch        : i686

Version     : 1.6.0

Release     : 8.el6_0.1

Size        : 371 k

Repo        : installed

From repo   : 163

Summary     : X client for remote desktop into Windows Terminal Server

URL         : http://www.rdesktop.org/

License     : GPLv2+

Description : rdesktop is an open source client for Windows NT Terminal Server and

            : Windows 2000 & 2003 Terminal Services, capable of natively speaking

            : Remote Desktop Protocol (RDP) in order to present the user's NT

            : desktop. Unlike Citrix ICA, no server extensions are required.

[root@www.kashu.org ~]# rdesktop 

rdesktop: A Remote Desktop Protocol client.

Version 1.6.0. Copyright (C) 1999-2008 Matthew Chapman.

See http://www.rdesktop.org/ for more information.



Usage: rdesktop [options] server[:port]

   -u: user name（用户名）

   -d: domain

   -s: shell

   -c: working directory

   -p: password (- to prompt)（密码）

   -n: client hostname

   -k: keyboard layout on server (en-us, de, sv, etc.)

   -g: desktop geometry (WxH,分辨率示例：使用-g workarea可自适应铺满当前linux窗口大小, 1024x768, 1280x1024, 1440x900, 1880x1024)

   -f: full-screen mode（全屏模式，可使用Ctrl + Alt + Enter组合键退出全屏）

   -b: force bitmap updates

   -L: local codepage

   -A: enable SeamlessRDP mode

   -B: use BackingStore of X-server (if available)

   -e: disable encryption (French TS)

   -E: disable encryption from client to server

   -m: do not send motion events

   -C: use private colour map

   -D: hide window manager decorations

   -K: keep window manager key bindings

   -S: caption button size (single application mode)

   -T: window title

   -N: enable numlock syncronization

   -X: embed into another window with a given id.

   -a: connection colour depth

   -z: enable rdp compression

   -x: RDP5 experience (m[odem 28.8], b[roadband], l[an] or hex nr.)

   -P: use persistent bitmap caching

   -r: enable specified device redirection (this flag can be repeated)

         '-r comport:COM1=/dev/ttyS0': enable serial redirection of /dev/ttyS0 to COM1

             or      COM1=/dev/ttyS0,COM2=/dev/ttyS1

         '-r disk:floppy=/mnt/floppy': enable redirection of /mnt/floppy to 'floppy' share

             or   'floppy=/mnt/floppy,cdrom=/mnt/cdrom'

         '-r clientname=<client name>': Set the client name displayed

             for redirected disks

         '-r lptport:LPT1=/dev/lp0': enable parallel redirection of /dev/lp0 to LPT1

             or      LPT1=/dev/lp0,LPT2=/dev/lp1

         '-r printer:mydeskjet': enable printer redirection

             or      mydeskjet="HP LaserJet IIIP" to enter server driver as well

         '-r sound:[local[:driver[:device]]|off|remote]': enable sound redirection

                     remote would leave sound on server

                     available drivers for 'local':

                     libao:     libao output driver, default device: system dependent

         '-r clipboard:[off|PRIMARYCLIPBOARD|CLIPBOARD]': enable clipboard

                      redirection.

                      'PRIMARYCLIPBOARD' looks at both PRIMARY and CLIPBOARD

                      when sending data to server.

                      'CLIPBOARD' looks at only CLIPBOARD.

         '-r scard[:"Scard Name"="Alias Name[;Vendor Name]"[,...]]

          example: -r scard:"eToken PRO 00 00"="AKS ifdh 0"

                   "eToken PRO 00 00" -> Device in Linux/Unix enviroment

                   "AKS ifdh 0"       -> Device shown in Windows enviroment 

          example: -r scard:"eToken PRO 00 00"="AKS ifdh 0;AKS"

                   "eToken PRO 00 00" -> Device in Linux/Unix enviroment

                   "AKS ifdh 0"       -> Device shown in Windows enviroment 

                   "AKS"              -> Device vendor name                 

   -0: attach to console

   -4: use RDP version 4

   -5: use RDP version 5 (default)

示例：

[root@www.kashu.org ~]# rdesktop -u username -p password -r clipboard:CLIPBOARD -A -a 8(8|15|16|24，颜色深度)192.168.1.1

kashu@kashu:~$ rdesktop -g 1880x1024 -P -u username -p password -d domain_name -r clipboard:CLIPBOARD 10.5.255.254

#console
rdesktop -u administrator -p amttgroup -r clipboard:CLIPBOARD -g 1024x700 -P -m -E -0 -a 15 222.66.56.206:51181

#non console
rdesktop -u administrator -p amttgroup -r clipboard:CLIPBOARD -g 1024x700 -P -m -E -0 -a 15 222.66.56.206:51181

