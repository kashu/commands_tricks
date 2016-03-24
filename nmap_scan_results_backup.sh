-sn	No port scan
-n	No DNS resolution
-Pn	No ping
-PR	ARP Ping

--traceroute	Trace path to host


#bypassing firewalls
-PS port list	TCP SYN Ping
-PA port list	TCP ACK Ping
-PU port list	UDP Ping


在十里堡甲3号院蹭网时使用的默认网关
$ sudo nmap -n -A -P0 --version-all --osscan-guess 192.168.162.1

Starting Nmap 6.47 ( http://nmap.org ) at 2015-05-11 12:47 CST

Nmap scan report for 192.168.162.1
Host is up (0.00026s latency).
Not shown: 997 closed ports
PORT     STATE SERVICE        VERSION
1723/tcp open  pptp           MikroTik (Firmware: 1)
2000/tcp open  bandwidth-test MikroTik bandwidth-test server
8291/tcp open  unknown
MAC Address: 00:15:17:2C:16:90 (Intel Corporate)
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6
OS details: Linux 2.6.19 - 2.6.36
Network Distance: 1 hop
Service Info: Host: JG

TRACEROUTE
HOP RTT     ADDRESS
1   0.26 ms 192.168.162.1

OS and Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 200.49 seconds
################################################################
只使用ARP协议扫描（不发出ICMP包）
$ sudo nmap -sn -n 192.168.162.1-254

Starting Nmap 6.47 ( http://nmap.org ) at 2015-05-11 13:12 CST
Nmap scan report for 192.168.162.1
Host is up (-0.10s latency).
MAC Address: 00:15:17:2C:16:90 (Intel Corporate)
Nmap scan report for 192.168.162.201
Host is up (0.00014s latency).
MAC Address: D0:27:88:5E:5F:E0 (Hon Hai Precision Ind.Co.Ltd)
Nmap scan report for 192.168.162.205
Host is up (0.00097s latency).
MAC Address: B8:AE:ED:25:98:D5 (Elitegroup Computer Systems Co.)
Nmap scan report for 192.168.162.249
Host is up (0.00011s latency).
MAC Address: 14:E6:E4:40:24:9F (Tp-link Technologies CO.)
Nmap scan report for 192.168.162.203
Host is up.
Nmap done: 254 IP addresses (5 hosts up) scanned in 7.08 seconds
################################################################
对201进行一个初步的快速而简单的扫描
$ sudo nmap -F -n 192.168.162.201
sudo: unable to resolve host kashu

Starting Nmap 6.47 ( http://nmap.org ) at 2015-05-11 13:15 CST
Nmap scan report for 192.168.162.201
Host is up (0.00013s latency).
Not shown: 97 closed ports
PORT    STATE SERVICE
135/tcp open  msrpc
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
MAC Address: D0:27:88:5E:5F:E0 (Hon Hai Precision Ind.Co.Ltd)

Nmap done: 1 IP address (1 host up) scanned in 1.49 seconds
################################################################
对205进行一个相对综合的扫描，扫描开放的服务、操作系统版本探测，并在屏幕上实时显示扫描过程中的动态信息
$ sudo nmap -A --version-all --osscan-guess -n -sn -v 192.168.162.205
WARNING: OS Scan is unreliable without a port scan.  You need to use a scan type along with it, such as -sS, -sT, -sF, etc instead of -sn
QUITTING!
13:17 kashu@kashu:~$ sudo nmap -A --version-all --osscan-guess -n -v 192.168.162.205

Starting Nmap 6.47 ( http://nmap.org ) at 2015-05-11 13:17 CST
NSE: Loaded 118 scripts for scanning.
NSE: Script Pre-scanning.
Initiating ARP Ping Scan at 13:17
Scanning 192.168.162.205 [1 port]
Completed ARP Ping Scan at 13:17, 0.21s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 13:17
Scanning 192.168.162.205 [1000 ports]
Discovered open port 5357/tcp on 192.168.162.205
Completed SYN Stealth Scan at 13:18, 17.20s elapsed (1000 total ports)
Initiating Service scan at 13:18
Scanning 1 service on 192.168.162.205
Completed Service scan at 13:18, 11.02s elapsed (1 service on 1 host)
Initiating OS detection (try #1) against 192.168.162.205
Retrying OS detection (try #2) against 192.168.162.205
NSE: Script scanning 192.168.162.205.
Initiating NSE at 13:18
Completed NSE at 13:18, 0.06s elapsed
Nmap scan report for 192.168.162.205
Host is up (0.00042s latency).
Not shown: 999 filtered ports
PORT     STATE SERVICE VERSION
5357/tcp open  http    Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-methods: No Allow or Public header in OPTIONS response (status code 503)
|_http-title: Service Unavailable
MAC Address: B8:AE:ED:25:98:D5 (Elitegroup Computer Systems Co.)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Aggressive OS guesses: Microsoft Windows Phone 7.5 or 8.0 (97%), Microsoft Windows Server 2008 or 2008 Beta 3 (97%), Windows Server 2008 R2 (97%), Microsoft Windows 7 Professional or Windows 8 (97%), Microsoft Windows Vista SP0 or SP1, Windows Server 2008 SP1, or Windows 7 (97%), Microsoft Windows Vista SP2, Windows 7 SP1, or Windows Server 2008 (97%), Microsoft Windows Server 2008 SP1 (94%), Microsoft Windows 8 Enterprise (91%), Microsoft Windows Vista SP0 - SP1 (91%), Microsoft Windows Server 2012 (90%)
No exact OS matches for host (test conditions non-ideal).
Uptime guess: 0.189 days (since Mon May 11 08:46:11 2015)
Network Distance: 1 hop
TCP Sequence Prediction: Difficulty=262 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

TRACEROUTE
HOP RTT     ADDRESS
1   0.42 ms 192.168.162.205

NSE: Script Post-scanning.
Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 33.61 seconds
           Raw packets sent: 3104 (141.792KB) | Rcvd: 39 (2.044KB)
################################################################
对201进行一个相对综合的扫描
$ sudo nmap -A -n --osscan-guess --version-all -sS -sU 192.168.162.201

Starting Nmap 6.47 ( http://nmap.org ) at 2015-05-11 13:23 CST

Nmap scan report for 192.168.162.201
Host is up (0.00018s latency).
Not shown: 1990 closed ports
PORT     STATE         SERVICE      VERSION
135/tcp  open          msrpc        Microsoft Windows RPC
139/tcp  open          netbios-ssn
445/tcp  open          netbios-ssn
123/udp  open          ntp          NTP v3
| ntp-info: 
|_  
137/udp  open          netbios-ns   Microsoft Windows NT netbios-ssn (workgroup: WORKGROUP)
138/udp  open|filtered netbios-dgm
445/udp  open|filtered microsoft-ds
1072/udp open|filtered cardax
1524/udp open|filtered ingreslock
4000/udp open|filtered icq
MAC Address: D0:27:88:5E:5F:E0 (Hon Hai Precision Ind.Co.Ltd)
Device type: general purpose
Running: Microsoft Windows XP
OS CPE: cpe:/o:microsoft:windows_xp::sp2 cpe:/o:microsoft:windows_xp::sp3
OS details: Microsoft Windows XP SP2 or SP3
Network Distance: 1 hop
Service Info: Host: WWW-66CF8DEB8EC; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_nbstat: NetBIOS name: WWW-66CF8DEB8EC, NetBIOS user: <unknown>, NetBIOS MAC: d0:27:88:5e:5f:e0 (Hon Hai Precision Ind.Co.Ltd)
| smb-os-discovery: 
|   OS: Windows XP (Windows 2000 LAN Manager)
|   OS CPE: cpe:/o:microsoft:windows_xp::-
|   Computer name: WWW-66CF8DEB8EC
|   NetBIOS computer name: WWW-66CF8DEB8EC
|   Workgroup: WORKGROUP
|_  System time: 2015-05-11T13:25:31+08:00
| smb-security-mode: 
|   Account that was used for smb scripts: guest
|   User-level authentication
|   SMB Security: Challenge/response passwords supported
|_  Message signing disabled (dangerous, but default)
|_smbv2-enabled: Server doesn't support SMBv2 protocol

TRACEROUTE
HOP RTT     ADDRESS
1   0.18 ms 192.168.162.201

OS and Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 251.89 seconds
################################################################
$ sudo nmap -PR -sn 192.168.1.1-254

Starting Nmap 6.47 ( http://nmap.org ) at 2015-05-14 14:44 CST
Nmap scan report for localhost (192.168.1.1)
Host is up (0.22s latency).
MAC Address: D8:15:0D:43:D9:36 (Tp-link Technologies Co.)
Nmap scan report for localhost (192.168.1.100)
Host is up (0.063s latency).
MAC Address: 00:F7:6F:BB:09:66 (Apple)
Nmap scan report for localhost (192.168.1.103)
Host is up (0.049s latency).
MAC Address: 68:DF:DD:A4:74:16 (Xiaomi)
Nmap scan report for localhost (192.168.1.105)
Host is up (0.14s latency).
MAC Address: 00:24:21:A6:5D:D9 (Micro-star Int'l CO.)
Nmap scan report for localhost (192.168.1.109)
Host is up (0.082s latency).
MAC Address: 38:BC:1A:B6:14:F7 (Meizu technology co.)
Nmap scan report for localhost (192.168.1.118)
Host is up (0.16s latency).
MAC Address: A4:5E:60:04:CC:88 (Unknown)
Nmap scan report for localhost (192.168.1.119)
Host is up (0.17s latency).
MAC Address: CC:3A:61:18:3B:83 (Samsung Electro Mechanics CO.)
Nmap scan report for localhost (192.168.1.124)
Host is up.
Nmap done: 254 IP addresses (8 hosts up) scanned in 6.62 seconds
################################################################
$ sudo nmap -A -n -P0 192.168.1.100

Starting Nmap 6.47 ( http://nmap.org ) at 2015-05-14 14:42 CST
Nmap scan report for 192.168.1.100
Host is up (0.0082s latency).
Not shown: 999 closed ports
PORT      STATE SERVICE    VERSION
62078/tcp open  tcpwrapped
MAC Address: 00:F7:6F:BB:09:66 (Apple)
Device type: general purpose|media device|phone
Running: Apple Mac OS X 10.7.X|10.9.X|10.8.X, Apple iOS 4.X|5.X|6.X
OS CPE: cpe:/o:apple:mac_os_x:10.7 cpe:/o:apple:mac_os_x:10.9 cpe:/o:apple:mac_os_x:10.8 cpe:/o:apple:iphone_os:4 cpe:/a:apple:apple_tv:4 cpe:/o:apple:iphone_os:5 cpe:/o:apple:iphone_os:6
OS details: Apple Mac OS X 10.7.0 (Lion) - 10.9.2 (Mavericks) or iOS 4.1 - 7.1 (Darwin 10.0.0 - 14.0.0)
Network Distance: 1 hop

TRACEROUTE
HOP RTT     ADDRESS
1   8.23 ms 192.168.1.100

OS and Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 108.36 seconds
################################################################
$ sudo nmap -sS -n -Pn -T4 192.168.1.105

Starting Nmap 6.47 ( http://nmap.org ) at 2015-05-14 16:58 CST
Nmap scan report for 192.168.1.105
Host is up (0.12s latency).
Not shown: 993 filtered ports
PORT     STATE SERVICE
135/tcp  open  msrpc
139/tcp  open  netbios-ssn
445/tcp  open  microsoft-ds
843/tcp  open  unknown
5357/tcp open  wsdapi
7000/tcp open  afs3-fileserver
9000/tcp open  cslistener
MAC Address: 00:24:21:A6:5D:D9 (Micro-star Int'l CO.)

Nmap done: 1 IP address (1 host up) scanned in 54.83 seconds
################################################################

