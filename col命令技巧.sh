col
-x  将tab键转换成对等的空格键
-b  在文字内有反斜杠(/)时，仅保留反斜杠最后接的那个字符

#当我们直接把man帮助文件导出来，里面会有很多带^的特殊符号
$ man ip > ip.txt
$ vi ip.txt
IP(8)                                Linux                               IP(8)

N^HNA^HAM^HME^HE
       ip - show / manipulate routing, devices, policy routing and tunnels

S^HSY^HYN^HNO^HOP^HPS^HSI^HIS^HS
       i^Hip^Hp [ _^HO_^HP_^HT_^HI_^HO_^HN_^HS ] _^HO_^HB_^HJ_^HE_^HC_^HT { _^HC_^HO_^HM_^HM_^HA_^HN_^HD | h^Hhe^Hel^Hlp^Hp }

#①用col把man帮助文件转换成纯文本文件：
$ col -b < ip.txt > ip2.txt

$ vi ip2.txt 
IP(7)                                Linux                               IP(8)

NAME
       ip - show / manipulate routing, devices, policy routing and tunnels

#②把tab键转换成对等的空格键（man.config有一些文本是用tab键进行对齐的，^I）
$ grep '^MANPATH' /etc/manpath.config | head -n3 | cat -A
MANPATH_MAP^I/bin^I^I^I/usr/share/man$
MANPATH_MAP^I/usr/bin^I^I/usr/share/man$
MANPATH_MAP^I/sbin^I^I^I/usr/share/man$

$ grep '^MANPATH' /etc/manpath.config | head -n3 | col -x | cat -A
MANPATH_MAP     /bin                    /usr/share/man$
MANPATH_MAP     /usr/bin                /usr/share/man$
MANPATH_MAP     /sbin                   /usr/share/man$

