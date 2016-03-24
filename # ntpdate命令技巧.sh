ntpdate命令由ntpdate这个软件包所提供
# rpm -qf `which ntpdate` 
ntpdate-4.2.4p8-2.el6.i686
如果未安装，则执行：yum -y install ntpdate


时间同步方法
# ntpdate ntp服务器域名或IP
例：
# ntpdate 3.cn.pool.ntp.org
# ntpdate 210.72.145.44 //是中国国家授时中心的官方服务器。
http://www.pool.ntp.org是NTP的官方网站,在这上面我们可以找到离我们国家的NTP Server cn.pool.ntp.org.它有3个服务器地址：
3.cn.pool.ntp.org
1.asia.pool.ntp.org
3.asia.pool.ntp.org
（直接用域名有时有问题，可以先ping出它们的IP，然后用IP地址同步）




變更 Linux 系統預設時區(timezone)
1. 使用 root 帳號登入終端
2. 執行 date 指令，此時會出現類似 Wed Oct 2 14:11:29 CST 2013 的訊息，其中 CST 就是目前系統預設時區
3. 切換到 /usr/share/zoneinfo 目錄，其中有所有時區(timezone)的列表， Shanghai 時區在 Asia 下
4. 執行 mv /etc/localtime  /etc/localtime.bak 備份目前設定
4. 執行 cp -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 將欲使用的時區 softlink 到 /etc/localtime
6.  修改 /etc/sysconfig/clock 檔案內容，改為 ZONE="Asia/Shanghai"
7.  執行 hwclock -w 同步硬體時鐘（把系统时间写入进BIOS里）

查看BIOS当前时间：hwclock
查看当前系统时区：date -R

时间同步：ntpdate cn.pool.ntp.org（yum install ntpdate -y）
可写入到crontab中：/usr/sbin/ntpdate cn.pool.ntp.org &> /dev/null
亚洲权威时间同步服务器列表：http://www.pool.ntp.org/zone/asia
