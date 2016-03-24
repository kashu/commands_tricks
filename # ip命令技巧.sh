Linux中网络参数大致包含以下内容：
IP地址
子网掩码
默认网关
DNS服务器
主机名
历来Linux系统中修改这些参数的方式通常有：命令、文件两种。其中通过命令设置可以立即生效但重启后将失效，通过文件修改实现永久生效，但不会立即生效。
首先我们来看看命令的方式：
ifconfig：查看与设置IP地址、子网掩码
hostname：查看与设置主机名
route：   查看与设置路由信息（默认网关等）
通过文件的方式修改：
/etc/sysconfig/network-scripts/ifcfg-设备名（通常为ifcfg-eth0)
/etc/sysconfig/network
/etc/resolv.conf文件：设置DNS服务器
以上种种这些方式可以同时在5.0与6.0系统中实现，但6.0系统后官方文档中描述说：ifconfig与route是非常陈旧的命令，取而代之的是ip命令。
那么我们先看一下老的命令使用方式：
*************************************************************************
ifconfig  接口  选项|地址
#ifconfig  eth0  up  开启eth0网卡
#ifconfig  eth0  down  关闭eth0网卡
#ifconfig  eth0  -arp   关闭eth0网卡arp协议
#ifconfig  eth0  promisc 开启eth0网卡的混合模式
#ifconfig  eth0  mtu 1400 设置eth0网卡的最大传输单元为1400
#ifconfig  eth0  192.168.0.2/24 设置eth0网卡IP地址
#ifconfig  eth0  192.168.0.2  netmask 255.255.255.0 功能同上
*************************************************************************
主机名：
#hostname  查看主机名
#hostname  jacob.com 设置主机名为jacob.com
*************************************************************************
网关设置：
route  add [-net|-host] target [netmask] gw
route  del [-net|-host] target [netmask] gw
#route add  -net 192.168.3.0/24  gw  192.168.0.254 设置到192.168.3.0网段的网关为192.168.0.254
#route add  -net 192.168.3.0 netmask 255.255.255.0  gw  192.168.0.254 功能同上
#route add  -host 192.168.4.4  gw  192.168.0.254 设置到192.168.4.4主机的网关为192.168.0.254
#route del  -net 192.168.3.0/24  删除192.168.3.0网段的网关信息
#route del  -host 192.168.4.4  删除192.168.4.4主机的网关信息
#route add default gw  192.168.0.254 设置默认网关为192.168.0.254
#route del default gw  192.168.0.254 删除默认网关为192.168.0.254
*************************************************************************
而如今官方不再推荐使用如此陈旧的命令而推荐使用IP这个命令，以下我们看看它的用法：
man ip手册：http://linux.die.net/man/8/ip
ip  [选项]  操作对象{link|addr|route...}
#ip link show   显示网络接口信息
#ip link set eth0 up  开启网卡
#ip link set eth0 down  关闭网卡
#ip link set eth0 promisc on 开启网卡的混合模式
#ip link set eth0 promisc off 关闭网卡的混个模式
#ip link set eth0 txqueuelen 1200 设置网卡队列长度
#ip link set eth0 mtu 1400  设置网卡最大传输单元
 
#ip addr show  显示网卡IP信息
#ip addr add 192.168.0.1/24 dev eth0 设置eth0网卡IP地址192.168.0.1
#ip addr del 192.168.0.1/24 dev eth0 删除eth0网卡IP地址
 
#ip route list  查看路由信息
#ip route add 192.168.4.0/24 via 192.168.0.254 dev eth0设置192.168.4.0网段的网关为192.168.0.254,数据走eth0接口
#ip route add default via 192.168.0.254 dev eth0 设置默认网关为192.168.0.254
#ip route del 192.168.4.0/24  删除192.168.4.0网段的网关
#ip route del default   删除默认路由

查看所有网卡的信息
$ ip ad
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:e6:81:11 brd ff:ff:ff:ff:ff:ff
    inet 172.31.11.250/22 brd 172.31.11.255 scope global eth0
    inet6 fe80::20c:29ff:fee6:8111/64 scope link 
       valid_lft forever preferred_lft forever
3: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 00:12:7b:71:d4:11 brd ff:ff:ff:ff:ff:ff
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN 
    link/ether 9a:c1:9d:3b:27:11 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0

查看所有网卡的IPv4地址
$ ip -4 ad
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    inet 172.31.11.250/22 brd 172.31.11.255 scope global eth0
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN 
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0

查看所有网卡的IPv6地址
$ ip -6 ad
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qlen 1000
    inet6 fe80::20c:29ff:fee6:8111/64 scope link 
       valid_lft forever preferred_lft forever

查看所有网卡的IPv4地址信息，并且每个记录信息以一行显示
$ ip -o -4 ad
1: lo    inet 127.0.0.1/8 scope host lo
2: eth0    inet 172.31.11.250/22 brd 172.31.11.255 scope global eth0
4: virbr0    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0

查看所有网卡
$ ip li
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:e6:81:11 brd ff:ff:ff:ff:ff:ff
3: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 00:12:7b:71:d4:11 brd ff:ff:ff:ff:ff:ff
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN 
    link/ether 9a:c1:9d:3b:27:11 brd ff:ff:ff:ff:ff:ff
显示详细统计信息
$ ip -s li
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX: bytes  packets  errors  dropped overrun mcast   
    40394      579      0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    40394      579      0       0       0       0      
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:e6:81:11 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    403346366  415968   0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    42092166   331725   0       0       0       0      
3: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 00:12:7b:71:d4:11 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    0          0        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    0          0        0       0       0       0      
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN 
    link/ether 9a:c1:9d:3b:27:11 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    0          0        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    0          0        0       0       0       0      
显示更加详细的统计信息
$ ip -s -s li
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX: bytes  packets  errors  dropped overrun mcast   
    40394      579      0       0       0       0      
    RX errors: length  crc     frame   fifo    missed
               0        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    40394      579      0       0       0       0      
    TX errors: aborted fifo    window  heartbeat
               0        0       0       0      
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:e6:81:11 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    403348659  415981   0       0       0       0      
    RX errors: length  crc     frame   fifo    missed
               0        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    42092610   331730   0       0       0       0      
    TX errors: aborted fifo    window  heartbeat
               0        0       0       0      
3: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 00:12:7b:71:d4:11 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    0          0        0       0       0       0      
    RX errors: length  crc     frame   fifo    missed
               0        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    0          0        0       0       0       0      
    TX errors: aborted fifo    window  heartbeat
               0        0       0       0      
手工添加静态路由
$ sudo ip route add 1.0.0.0/8 via 127.0.0.1 dev lo
$ ip ro
default via 172.31.8.1 dev eth0 
1.0.0.0/8 via 127.0.0.1 dev lo 
172.31.8.0/22 dev eth0  proto kernel  scope link  src 172.31.11.250 
192.168.122.0/24 dev virbr0  proto kernel  scope link  src 192.168.122.1 

删除指定路由
$ sudo ip ro del 1.0.0.0/8 via 127.0.0.1 dev lo
*************************************************************************
接下来再看看通过文件修改网络参数：（CentOS6.2系统为例）
#cat  /etc/sysconfig/network-scripts/ifcfg-eth0 
DEVICE="eth0"   设备名
NM_CONTROLLED="yes"  设备是否被NetworkManager管理
ONBOOT="no"   开机是否启动
HWADDR=00:0C:29:E8:21:A2 硬件地址（MAC地址）
TYPE=Ethernet   类型
BOOTPROTO=none   启动协议{none|dhcp}
IPADDR=192.168.0.1  IP地址
PREFIX=24   子网掩码
GATEWAY=192.168.0.254  默认网关
DNS1=202.106.0.20  主DNS
DOMAIN=202.106.46.151  辅助DNS
UUID=5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03 设备UUID编号
*************************************************************************
#cat /etc/sysconfig/network
HOSTNAME=jacob.com 主机名
*************************************************************************
注意：在5.0时代DNS服务器写在/etc/resolv.conf文件中，但到了6.0时代DNS写在/etc/sysconfig/network-scripts/ifcfg-eth0文件中。
