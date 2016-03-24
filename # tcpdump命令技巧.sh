-i  指定抓取哪个网卡的包，如：-i eth0或-i wlan 0
-n  不把IP地址或端口号转换成名称形式
-c  当接收到多少个数据包后就自动退出此次抓包，如：-c 10，当抓到10个后包就自动退出
-w ./capture.cap直接把抓包内容保存到一个文件中，而不打印在屏幕上

#抓取eth0接口的5个非TCP类型的包，保存到test.cap文件中：
$ sudo tcpdump -i eth0 -c 5 '!'arp and '!'tcp -w ./test.cap

#抓取eth0接口的10个HTTP数据包，并且不把IP地址或端口号转换成名称形式，打印到屏幕上
$ sudo tcpdump -i eth0 -n -c 10  src or dst port 80

#注释：下面的括号不带也一样，带括号看着会更易读一些。
#抓取192.168.1.139和192.168.1彼此之间传输的HTTP数据包：
$ sudo tcpdump -i eth0 -c 5 '(src or dst 192.168.1.139) and (src or dst 192.168.1) and (src or dst port 80)' -n
#上面这条命令等同于下面这条：
$ sudo tcpdump -i eth0 -n host 192.168.1.139 and host 192.168.1.1 and port 80

#抓取与192.168.1.139有关的HTTPS和DNS数据包：
$ sudo tcpdump -i wlan0 -n 'host 192.168.1.139 and (port 443 or 53)'

#抓取与192.168.1.139有关的非HTTP和非HTTPS数据包：
$ sudo tcpdump -i wlan0 -n 'host 192.168.1.139 and (not port 80 and not 443)'

#不抓取IP和ARP包：
$ sudo tcpdump -i eth0 -n '! ip and ! arp'

#ipv6表示：ip6

#refer to :http://www.cnblogs.com/ggjucheng/archive/2012/01/14/2322659.html
#http://network.51cto.com/art/200512/15473.htm

