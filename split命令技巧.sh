split命令可以根据文件的大小或行数来分割文件，这样一个大文件就可以分割成若干个小文件
-b  后面可以接要分割成的文件大小，可加单位，如：b，k，m等
-l  以行数来进行分割

#$ cat passwd（原文件是这样的）
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/bin/sh
bin:x:2:2:bin:/bin:/bin/sh

#①$ split -l 1 passwd file（把原文件的每一行分割成一个文件）

$ cat fileaa
root:x:0:0:root:/root:/bin/bash

$ cat fileab
daemon:x:1:1:daemon:/usr/sbin:/bin/sh

$ cat fileac
bin:x:2:2:bin:/bin:/bin/sh

#②$ split -b 40 passwd test（把原文件分割成40字节的文件）
$ ll testa*
-rw-rw-r-- 1 kashu kashu 40 Mar 30 20:25 testaa
-rw-rw-r-- 1 kashu kashu 40 Mar 30 20:25 testab
-rw-rw-r-- 1 kashu kashu 17 Mar 30 20:25 testac
