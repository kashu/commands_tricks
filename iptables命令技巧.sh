# iptables -A INPUT -i eth0 -m mac --mac-source BC:30:5B:E3:55:E3 -j ACCEPT
# iptables -A INPUT -i eth0 -m mac --mac-source 0c:85:25:70:50:d1 -j ACCEPT
# iptables -A INPUT -i eth0 -p tcp -m multiport --dport 20:23,80,443 -j DROP
通过-m multiport [--sport|--dport]可以同时指定多个连续或不连续的端口
冒号表示连续的端口范围，20:23即20,21,22,23
逗号分隔表示不连续的端口
-A添加一条规则，默认添加的规则置于规则列表最末尾
-D删除某一条规则：
#iptables -D INPUT -i eth0 -p tcp --dport 443 -j DROP
-I插入某一条规则，通过指定数字编号以指定插入的顺序，不带数字编号默认插入到规则最前列：
#iptables -I INPUT 2 -i eth0 -p tcp -s 192.168.14.0/24 --dport 443 -j ACCEPT

查看iptables正在使用的配置：iptables -nL
清空当前正在使用的配置：iptables -F
iptables的配置文件保存在 /etc/sysconfig/iptables-config
保存（备份）规则至文件中：iptables-save > /root/iptables.bak
保存规则至系统中：
方法1：iptables-save > /etc/sysconfig/iptables
方法2：service iptables save




让一台设备在访问指定网站（如www.cisco.com）时直接跳转到指定的网站（如216.189.56.47的80端口）

iptables -t nat -I PREROUTING 1 -s 192.168.0.2 -d www.cisco.com -p tcp --dport 80 -j DNAT --to 216.189.56.47:80
让一台设备在访问任意网站（目的端口为80）时直接跳转到指定的网站（如216.189.56.47的80端口）

iptables -t nat -I PREROUTING 1 -s 192.168.0.2 -p tcp --dport 80 -j DNAT --to 216.189.56.47:80
让整个网段的所有设备在访问任意网站时都直接跳转到指定的网站（如216.189.56.47的80端口）

iptables -t nat -I PREROUTING 1 -s 192.168.0.0/24 -p tcp --dport 80 -j DNAT --to 216.189.56.47:80

sudo iptables -t nat -A PREROUTING -s 192.168.0.3 -p tcp --dport 80 -j DNAT --to 216.189.56.47:80
sudo iptables -t nat -A PREROUTING -s 192.168.0.4 -p tcp --dport 80 -j DNAT --to 216.189.56.47:80
sudo iptables -t nat -A PREROUTING -s 192.168.0.5 -p tcp --dport 80 -j DNAT --to 216.189.56.47:80
sudo iptables -t nat -A PREROUTING -s 192.168.0.6 -p tcp --dport 80 -j DNAT --to 216.189.56.47:80
sudo iptables -t nat -A PREROUTING -s 192.168.0.7 -p tcp --dport 80 -j DNAT --to 216.189.56.47:80
sudo iptables -t nat -A PREROUTING -s 192.168.0.8 -p tcp --dport 80 -j DNAT --to 216.189.56.47:80

sudo iptables -A FORWARD -s 192.168.0.2 -j ACCEPT
sudo iptables -A FORWARD -d 216.189.56.47 -j ACCEPT
sudo iptables -A FORWARD -p udp --dport 53 -j ACCEPT
sudo iptables -A FORWARD -p udp --sport 53 -j ACCEPT
sudo iptables -A FORWARD -p udp -m multiport --sport 4000:4005,8000:8005 -j ACCEPT
sudo iptables -A FORWARD -p tcp -m multiport --sport 4000:4005,8000:8005 -j ACCEPT
sudo iptables -A FORWARD -s 192.168.0.0/24 -j DROP
