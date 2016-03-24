mtr (安装：sudo apt-get install mtr -y)

mtr combines the functionality of the traceroute and ping programs in a single network diagnostic tool.

As mtr starts, it investigates the network connection between the host mtr runs on and HOSTNAME. by sending packets with purposely low TTLs. It continues to send packets with low TTL, noting the response time of the intervening routers. This allows mtr to print the response percentage and response times of the internet route to HOSTNAME. A sudden increase in packet loss or response time is often an indication of a bad (or simply overloaded) link.

The results are usually reported as round-trip-response times in miliseconds and the percentage of packetloss.


-n, --no-dns
	Use this option to force mtr to display numeric IP numbers and not try to resolve the host names.
-u
	Use UDP datagrams instead of ICMP ECHO.
-T, --tcp
	Use TCP SYN packets instead of ICMP ECHO. PACKETSIZE is ignored, since SYN packets can not contain data.
-P PORT, --port PORT
	The target port number for TCP traces.
-4	Use IPv4 only.
-6	Use IPv6 only.

-r, --report
This option puts mtr into report mode.  When in this mode, mtr will run for the number of cycles specified by  the  -c  option, and then print statistics and exit.
This  mode  is useful for generating statistics about network quality.  Note that each running instance of mtr generates a significant amount of network traffic.  Using mtr to measure the quality of your network may result in decreased  network  performance.

mtr -n 163.com
mtr -nu4 baidu.com

#把静态结果显示出来。（默认探测10次）
$ mtr -run4 baidu.com
Start: Mon May 11 16:38:28 2015
HOST: kashu                       Loss%   Snt   Last   Avg  Best  Wrst StDev
  1.|-- 192.168.162.1              0.0%    10    0.3   0.3   0.2   0.4   0.0
  2.|-- 119.161.255.177            0.0%    10    0.8   0.7   0.5   0.9   0.0
  3.|-- 172.30.1.1                 0.0%    10    4.8   1.9   0.5   7.6   2.3
  4.|-- 119.161.255.177            0.0%    10    0.8   2.4   0.7  11.3   3.5
  5.|-- 119.2.0.1                  0.0%    10    1.5   2.6   1.4   5.5   1.2
  6.|-- ???                       100.0    10    0.0   0.0   0.0   0.0   0.0
  7.|-- 220.181.0.9               60.0%    10    2.6 332.4   2.6 645.4 332.2
  8.|-- 220.181.177.77             0.0%    10    3.3   3.2   1.5   7.0   1.6
  9.|-- 202.97.57.106             40.0%    10    2.5 146.5   2.1 408.2 170.3
 10.|-- 219.158.38.245             0.0%    10   58.6  53.0  15.9  85.6  17.7
 11.|-- 219.158.101.109           90.0%    10   38.8  38.8  38.8  38.8   0.0
 12.|-- 124.65.194.6               0.0%    10   35.8  37.9  33.1  46.8   4.2
 13.|-- 61.51.113.250             20.0%    10   73.6  72.4  67.0  80.3   4.7
 14.|-- 202.106.43.38              0.0%    10   73.6  31.7   7.0  74.5  27.6
 15.|-- ???                       100.0    10    0.0   0.0   0.0   0.0   0.0

#-c1，探测次数
$ mtr -run4c1 baidu.com
Start: Mon May 11 16:39:24 2015
HOST: kashu                       Loss%   Snt   Last   Avg  Best  Wrst StDev
  1.|-- 192.168.162.1              0.0%     1    0.3   0.3   0.3   0.3   0.0
  2.|-- 119.161.255.177            0.0%     1    0.6   0.6   0.6   0.6   0.0
  3.|-- 172.30.1.1                 0.0%     1    0.7   0.7   0.7   0.7   0.0
  4.|-- 119.161.255.177            0.0%     1    5.3   5.3   5.3   5.3   0.0
  5.|-- 119.2.0.1                  0.0%     1    1.4   1.4   1.4   1.4   0.0
  6.|-- ???                       100.0     1    0.0   0.0   0.0   0.0   0.0
  7.|-- 220.181.17.146             0.0%     1    1.2   1.2   1.2   1.2   0.0
  8.|-- ???                       100.0     1    0.0   0.0   0.0   0.0   0.0	


