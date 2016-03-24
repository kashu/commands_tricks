Nping is an open-source tool for network packet generation, response analysis and response time measurement. Nping allows users to generate network packets of a wide range of protocols, letting them tune virtually any field of the protocol headers. While Nping can be used as a simple ping utility to detect active hosts, it can also be used as a raw packet generator for network stack stress tests, ARP poisoning, Denial of Service attacks, route tracing, and other purposes.
Additionally, Nping offers a special mode of operation called the "Echo Mode", that lets users see how the generated probes change in transit, revealing the differences between the transmitted packets and the packets received at the other end. See section "Echo Mode" for details.
The output from Nping is a list of the packets that are being sent and received. The level of detail depends on the options used.

root@bt:~# nping -c 1 --tcp -g 1111 -p 23 --flags syn 10.148.149.181
Starting Nping 0.6.01 ( http://nmap.org/nping ) at 2012-09-10 07:49 CST
SENT (0.0078s) TCP 10.148.149.217:1111 > 10.148.149.181:23 S ttl=64 id=47438 iplen=40  seq=1735883314 win=1480 
RCVD (0.0087s) TCP 10.148.149.181:23 > 10.148.149.217:1111 RA ttl=128 id=26615 iplen=40  seq=0 win=0 
 
Max rtt: 0.535ms | Min rtt: 0.535ms | Avg rtt: 0.535ms
Raw packets sent: 1 (40B) | Rcvd: 1 (46B) | Lost: 0 (0.00%)
Tx time: 0.00193s | Tx bytes/s: 20693.22 | Tx pkts/s: 517.33
Rx time: 1.00232s | Rx bytes/s: 45.89 | Rx pkts/s: 1.00
Nping done: 1 IP address pinged in 1.01 seconds

root@bt:~# nping -c 1 --tcp -g 1111 -p 23 --flags syn --data-string ILoveNetwork 10.148.149.181
Starting Nping 0.6.01 ( http://nmap.org/nping ) at 2012-09-10 07:56 CST
SENT (0.0093s) TCP 10.148.149.217:1111 > 10.148.149.181:23 S ttl=64 id=23920 iplen=52  seq=2738685757 win=1480 
RCVD (0.0101s) TCP 10.148.149.181:23 > 10.148.149.217:1111 RA ttl=128 id=28725 iplen=40  seq=0 win=0 
nping_event_handler(): TIMER killed: Resource temporarily unavailable
 
Max rtt: 0.526ms | Min rtt: 0.526ms | Avg rtt: 0.526ms
Raw packets sent: 1 (52B) | Rcvd: 1 (46B) | Lost: 0 (0.00%)
Tx time: 0.00192s | Tx bytes/s: 27097.45 | Tx pkts/s: 521.10
Rx time: 1.00194s | Rx bytes/s: 45.91 | Rx pkts/s: 1.00
Nping done: 1 IP address pinged in 1.02 seconds

root@bt:~# nping -c 1 --tr --tcp -g 1111 -p 22222 --flags syn --data-string "IT'S_TCP_TRACEROUTE" 10.18.38.1
Starting Nping 0.6.01 ( http://nmap.org/nping ) at 2012-09-10 08:11 CST
SENT (0.0126s) TCP 10.148.149.217:1111 > 10.18.38.1:22222 S ttl=1 id=17618 iplen=59  seq=343871021 win=1480 
RCVD (0.0183s) ICMP 10.148.149.254 > 10.148.149.217 TTL=0 during transit (type=11/code=0) ttl=255 id=63777 iplen=56 
 
Max rtt: 5.550ms | Min rtt: 5.550ms | Avg rtt: 5.550ms
Raw packets sent: 1 (59B) | Rcvd: 1 (56B) | Lost: 0 (0.00%)
Tx time: 0.00669s | Tx bytes/s: 8823.09 | Tx pkts/s: 149.54
Rx time: 1.00676s | Rx bytes/s: 55.62 | Rx pkts/s: 0.99
Nping done: 1 IP address pinged in 1.02 seconds


root@bt:~# nping -c 1 --tr --udp -g 1111 -p 22222 --data-string "UDP_TRACEROUTE" 10.18.38.1
Starting Nping 0.6.01 ( http://nmap.org/nping ) at 2012-09-10 08:25 CST
SENT (0.0057s) UDP 10.148.149.217:1111 > 10.18.38.1:22222 ttl=1 id=36582 iplen=42 
RCVD (0.0068s) ICMP 10.148.149.254 > 10.148.149.217 TTL=0 during transit (type=11/code=0) ttl=255 id=625 iplen=56 
 
Max rtt: 0.832ms | Min rtt: 0.832ms | Avg rtt: 0.832ms
Raw packets sent: 1 (42B) | Rcvd: 1 (56B) | Lost: 0 (0.00%)
Tx time: 0.00173s | Tx bytes/s: 24207.49 | Tx pkts/s: 576.37
Rx time: 1.00251s | Rx bytes/s: 55.86 | Rx pkts/s: 1.00
Nping done: 1 IP address pinged in 1.01 seconds

 




root@bt:~# nping -c 1 --tcp -g 1111 -p 22222 -S 10.148.149.181 --tos 7 --df --ttl 10 --data-string "Comprehensive_Test" 10.148.149.254
Starting Nping 0.6.01 ( http://nmap.org/nping ) at 2012-09-10 09:12 CST
SENT (0.0148s) TCP 10.148.149.181:1111 > 10.148.149.254:22222 S ttl=10 id=56687 iplen=58  seq=3359765745 win=1480 
 
Max rtt: N/A | Min rtt: N/A | Avg rtt: N/A
Raw packets sent: 1 (58B) | Rcvd: 0 (0B) | Lost: 1 (100.00%)
Tx time: 0.00171s | Tx bytes/s: 33819.24 | Tx pkts/s: 583.09
Rx time: 1.00255s | Rx bytes/s: 0.00 | Rx pkts/s: 0.00
Nping done: 1 IP address pinged in 1.02 seconds

BT5 R3的IP是10.148.149.217，发出TCP数据段，源IP为10.148.149.181，目的IP为10.148.149.254，源端口为1111，目的端口为22222，TOS为7，设置不分段比特位，TTL设置为10，附加数据“Comprehensive_Test”。
过程：先在10.148.149.217和10.148.149.181两台机器上分别启用wireshark，再在BT5 R3上执行命令，在wireshark进行包过滤。

 
 


 


For more information:  root@bt:~# man nping
http://nmap.org/book/nping-man.html
