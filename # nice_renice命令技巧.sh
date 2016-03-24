Linux 给予进程一个所谓的『优先运行序 (priority, PRI)』， 这个 PRI 值越低代表越优先的意思。不过这个 PRI 值是由核心动态调整的， 使用者无法直接调整 PRI 值的。
由于 PRI 是核心动态调整的，我们使用者也无权去干涉 PRI ！那如果你想要调整进程的优先运行序时，就得要透过 Nice 值了！Nice 值就是上表的 NI 啦！一般来说， PRI 与 NI 的相关性如下：

PRI(new) = PRI(old) + nice
不过你要特别留意到，如果原本的 PRI 是 50 ，并不是我们给予一个 nice = 5 ，就会让 PRI 变成55！ 因为 PRI 是系统『动态』决定的，所以，虽然 nice 值是可以影响 PRI ，不过， 最终的 PRI 仍是要经过系统分析后才会决定的。另外， nice 值是有正负的，而既然 PRI 越小越早被运行， 所以，当 nice 值为负值时，那么该进程就会降低 PRI 值，亦即会变得较优先被处理。此外，你必须要留意到：

nice 值可调整的范围为 -20 ~ 19 ；
root 可随意调整自己或他人进程的 Nice 值，且范围为 -20 ~ 19 ；
一般使用者仅可调整自己进程的 Nice 值，且范围仅为 0 ~ 19 (避免一般用户抢占系统资源)；
一般使用者仅可将 nice 值越调越高，例如本来 nice 为 5 ，则未来仅能调整到大于 5；
这也就是说，要调整某个进程的优先运行序，就是『调整该程序的 nice 值』啦！那么如何给予某个进程 nice 值呢？有两种方式，分别是：

一开始运行程序就立即给予一个特定的 nice 值：用 nice 命令；
调整某个已经存在的 PID 的 nice 值：用 renice 命令。

1）新运行的程序，用nice直接赋予新的nice值
# ping 163.com >& /dev/null &
# ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
4 S     0  2301  2299  0  80   0 - 27438 wait   pts/1    00:00:00 bash
4 S     0  2318  2301  0  80   0 - 27393 poll_s pts/1    00:00:00 ping
4 R     0  2319  2301  0  80   0 - 27031 -      pts/1    00:00:00 ps
# nice -n 10 ping 163.com >& /dev/null &
# ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
4 S     0  2301  2299  0  80   0 - 27438 wait   pts/1    00:00:00 bash
4 S     0  2318  2301  0  80   0 - 27393 skb_re pts/1    00:00:00 ping
4 S     0  2320  2301  0  90  10 - 27393 poll_s pts/1    00:00:00 ping
4 R     0  2321  2301  0  80   0 - 27030 -      pts/1    00:00:00 ps

2）已运行的程序，使用renice重新调整
$ ps -le
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
1 Z  1000  2251  2222  0  80   0 -     0 exit   ?        00:00:00 lightdm-session <defunct>
0 Z  1000  3675  3374  0  80   0 -     0 exit   ?        00:00:00 chromium-browse <defunct>
0 Z  1000  4103  3374  0  80   0 -     0 exit   ?        00:00:00 chromium-browse <defunct>

$ renice 19 2251（把PID为2251的进程的优先级调整为19）
2251 (process ID) old priority 0, new priority 19

$ ps -le | grep 2251（优先级已被调整为19）
1 Z  1000  2251  2222  0  99  19 -     0 exit   ?        00:00:00 lightdm-session <defunct>

$ renice 19 3675 4103（可同时调整多个进程的优先级）
3675 (process ID) old priority 0, new priority 19
4103 (process ID) old priority 0, new priority 19

$ ps -le | egrep '(3675|4103)'
0 Z  1000  3675  3374  0  99  19 -     0 exit   ?        00:00:00 chromium-browse <defunct>
0 Z  1000  4103  3374  0  99  19 -     0 exit   ?        00:00:00 chromium-browse <defunct>

还可以针对指定用户，把这些用户的进程优先级全部做调整
把kashu用户所有进程的优先级都设置为1
$ sudo renice 1 -u kashu
1000 (user ID) old priority 0, new priority 1

用ps -lu kashu可以看到，该用户所有的进程的优先级都变成了81，nice都变成了1
$ ps -lu kashu | head
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
1 S  1000  2211     1  0  81   1 - 78032 poll_s ?        00:00:00 gnome-keyring-d
4 S  1000  2222  2125  0  81   1 - 101017 poll_s ?       00:00:00 gnome-session
1 Z  1000  2251  2222  0  81   1 -     0 exit   ?        00:00:00 lightdm-session <defunct>

把kashu、mysql、root这三个用户的所有进程的优级都设置为-2
$ sudo renice -2 -u kashu mysql root

优先级会继承
当前bash的优先级是81，nice为1，在bash下产生的所有子进程都会继续父进程的优先级
$ ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1000  4985  4978  0  81   1 -  6414 wait   pts/0    00:00:00 bash
0 R  1000  5921  4985  0  81   1 -  2829 -      pts/0    00:00:00 ps

在bash下运行了两个程序，这些程序所产生的进程的父进程是bash
$ ping g.cn >& /dev/null &
$ conky &

再看这两个启动的进程，包括ps这个进程，优先级都继承了父进程bash的
$ ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1000  4985  4978  0  81   1 -  6414 wait   pts/0    00:00:00 bash
4 S  1000  5925  4985  0  81   1 -  3714 wait_f pts/0    00:00:00 ping
0 S  1000  5928  4985  3  81   1 - 173194 poll_s pts/0   00:00:00 conky
0 R  1000  5939  4985  0  81   1 -  2829 -      pts/0    00:00:00 ps

