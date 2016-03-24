#录制字符界面的所有操作
script -t 2>> test.t -a test.s -q
#注意exit是退出录制
eixt
#播放。-d 1.4和-d 2分别表示以1.4或2倍的速率播放
scriptreplay -t test.t test.s
scriptreplay -t test.t test.s -d 1.4
scriptreplay -t test.t test.s -d 2

#查看各信道占用情况，进而挑选一个干扰最少的信道给路由器或AP使用
sudo iwlist wlan0 scan | awk '/\(Channel/{print $NF}' | sort -n | uniq -c
#若安装了colout，可高亮显示出1、6、11信道
sudo iwlist wlan0 scan | awk '/\(Channel/{print $NF}' | sort -n | uniq -c | colout '(1\)|6\)|11\))'
#（注：前面一列数字表示有多少个设备正在使用此信道，后面的数字是信道）
      7 1)
      2 3)
      3 4)
      1 5)
      5 6)
      1 8)
      1 9)
      4 11)
      3 13)

#显示eth0, wlan0的MAC地址
ip a s eth0 | awk '/link/{print $2}'
ip a s wlan0 | awk '/link/{print $2}'

ifconfig eth0 | awk '/Link/{print $NF}'
ifconfig wlan0 | awk '/Link/{print $NF}'

#显示eth0, wlan0的IP地址
ip a s eth0 | awk -F'[ /]+' '/inet/{print $3}'
ip a s wlan0 | awk -F'[ /]+' '/inet/{print $3}'

ifconfig eth0 | awk -F'[ :]+' '/inet/{print $4}'
ifconfig wlan0 | awk -F'[ :]+' '/inet/{print $4}'

#ip命令
ip ad sh eth0
ip li sh wlan0
ip a
ip l
ip r
ip n
#手工加一条静态路由
sudo ip ro ad 8.8.8.8/32 via 192.168.1.111
#手工设置一条默认路由（默认网关）
sudo ip ro ad 0.0.0.0/0 via 192.168.1.222
#手工删除一条静态路由
sudo ip ro de 8.8.8.8/32
#临时更改MAC地址
sudo ip li se add 00:11:22:88:88:88 dev eth0

#pstree以树型结构直观展现出所有进程信息
pstree -pauU | less

#netstat黄金组合
sudo netstat -tunape
sudo ss -tunap | col 或 sudo ss -tunap | column -t

#dstat黄金组合，这里的网卡指定为eth0了
sudo dstat -lcdnmspyt -N eth0 --proc-count --net-packets --disk-util
#下面这段好记，够用
sudo dstat -lcdnmspyt -N eth0

#nmap神器
#快速主机发现
sudo nmap -sn 192.168.1.0/24
#快速基本扫描，不进行主机发现的探测（即不会产生ICMP包，但是会进行ARP探测，这是必需的），不进行任何DNS解析
sudo nmap -n -T4 -Pn -F 192.168.1.1-3
#综合扫描，目标范围是192.168.1.100, 192.168.1.105-192.168.1.110, 192.168.1.200
sudo nmap -n -T4 -Pn -A 192.168.1.100,105-110,200
#针对性扫描1：使用TCP半开连接扫描指定的TCP端口、尽力探测操作系统版本、服务版本
sudo nmap -n -T4 -sS -p T:20-23,80,443 --osscan-guess -sV 192.168.1.1,100,200
#针对性扫描2：使用UDP扫描指定的端口、操作系统版本、服务版本、目标范围是192.168.1-254.1和192.168.1-254.254
sudo nmap -n -T4 -sU -p U:53,69,123 -O -sV 192.168.1-254.1,254
#针对性扫描3：使用TCP半开连接扫描指定的TCP和UDP端口、操作系统版本、服务版本、导出扫描结果、路由跟踪、扫描结果输出到文件中
sudo nmap -n -T4 -sS -sU -p 20-22,53,80,443 -O -sV -oN ./nmap.port.scan.txt --packet-trace www.baidu.com

#vmstat黄金组合
sudo vmstat -w 1


free -h
#有些老版本不支持-h，但-m中支持的
free -m

#df
df -hT
df -hTtext4

#find把指定路径下所有文件的完全路径都列出来了
find $PWD | less
find $PWD -type d | less
find $PWD -type f | less

#rename批量改名神器（支持正则表达式。-n安全查看，不加-n就直接改名了！无法undo哦）
rename -n 's/A/b/' *
rename -n 's/.*123//' *.txt
rename -n 's/^第//' *.pdf
rename -n 's/\[ç©ºä¸\­è‹±è¯\­æ•™å®¤\]\[Studio\.Classroom\]//' *
find $PWD -name '*.avi' | rename -n 's/\[.*\]//'
find . -name 'EnglishPod.Intro.*' -exec rename -n 's/EnglishPod\.Intro\.//' {} \;

#用串口线连接交换机、路由器、防火墙……注意断行符可能会是坑
sudo miniterm.py -p /dev/ttyUSB0 --lf
sudo miniterm.py -p /dev/ttyUSB0 --cr

#ccze看日志或文本文件很舒服
ccze -A < /var/log/dmesg | less -R

#rdesktop远程连接Windows桌面
rdesktop -u username -p password -r clipboard:CLIPBOARD -A -a 8(8|15|16|24，颜色深度)192.168.1.1

#Win下的文件传到Linux下文件名变乱码？用convmv转换，注意--notest就直接转了
convmv -f gbk -t utf8 -r utf8编码的文件名(或用*表示全部)
convmv -f gbk -t utf8 --notest -r utf8编码的文件名(或用*表示全部)

#dmidecode查看电脑硬件信息
sudo dmidecode
sudo dmidecode -t processor
#用man自己探索
man dmidecode

#看磁盘、U盘挂载信息，喜欢用哪个自己挑
findmnt
mount | column -t

#mtr网络诊断工具
mtr cisco.com
mtr -un4c100 cisco.com
mtr -run4c1000 cisco.com

