$ pstree -pauU | less

init,1
  ├─ModemManager,791
  │   ├─{ModemManager},916
  │   └─{ModemManager},918
  ├─NetworkManager,815
  │   ├─dnsmasq,5596,nobody --no-resolv --keep-in-foreground --no-hosts --bind-interfaces...
  │   ├─{NetworkManager},820
  │   ├─{NetworkManager},823
  │   └─{NetworkManager},824
  ├─accounts-daemon,1805
  │   ├─{accounts-daemon},1807
  │   └─{accounts-daemon},1808
  ├─acpid,1146 -c /etc/acpi/events -s /var/run/acpid.socket
  ├─bluetoothd,792
  ├─colord,2765,colord
  │   ├─{colord},2778
  │   └─{colord},2779
  ├─cron,1137
  ├─dbus-daemon,777,messagebus --system --fork
  ├─getty,978 -8 38400 tty4
  ├─getty,982 -8 38400 tty5
  ├─getty,997 -8 38400 tty2
  ├─getty,998 -8 38400 tty3
  ├─getty,1001 -8 38400 tty6
  ├─getty,4268 -8 38400 tty1
  ├─hostd-worker,2998 -a /etc/vmware/hostd/config.xml
  │   ├─{hostd-worker},3115
  │   ├─{hostd-worker},3116
  │   ├─{hostd-worker},3117
  │   ├─{hostd-worker},3118
  │   ├─{hostd-worker},3119
  │   ├─{hostd-worker},3120
  │   ├─{hostd-worker},4253
  │   ├─{hostd-worker},4254
  │   ├─{hostd-worker},4259
  │   └─{hostd-worker},4274
  ├─irqbalance,1144
  ├─kerneloops,2343,kernoops
  ├─lightdm,1796
  │   ├─Xorg,1817 -core :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch
  │   │   ├─{Xorg},1834
  │   │   └─{Xorg},1835
  │   ├─lightdm,1841 --session-child 12 15
  │   │   ├─init,1852,kashu --user
  │   │   │   ├─at-spi-bus-laun,2224 --launch-immediately
  │   │   │   │   ├─dbus-daemon,2230 --config-file=/etc/at-spi2/accessibility.conf --nofork --print-address 3
  │   │   │   │   ├─{at-spi-bus-laun},2227
  │   │   │   │   ├─{at-spi-bus-laun},2229
  │   │   │   │   └─{at-spi-bus-laun},2232
  │   │   │   ├─at-spi2-registr,2247 --use-gnome-session
  │   │   │   │   └─{at-spi2-registr},2272
  │   │   │   ├─bamfdaemon,2323
  │   │   │   │   ├─{bamfdaemon},2350
  │   │   │   │   ├─{bamfdaemon},2352
  │   │   │   │   └─{bamfdaemon},2354
  │   │   │   ├─chromium-browse,22419
  │   │   │   │   ├─chrome-sandbox,22435 /usr/lib/chromium-browser/chromium-browser --type=zygote--ppapi-flash-path=/usr/lib/pepper
  │   │   │   │   │   └─chromium-browse,22436
  │   │   │   │   │       └─chromium-browse,22440
  │   │   │   │   │           ├─chromium-browse,8276
  │   │   │   │   │           │   ├─{chromium-browse},8281
  │   │   │   │   │           │   ├─{chromium-browse},8283
  │   │   │   │   │           │   ├─{chromium-browse},8284
  │   │   │   │   │           │   ├─{chromium-browse},8285
  │   │   │   │   │           │   ├─{chromium-browse},8288
  │   │   │   │   │           │   ├─{chromium-browse},8289
  │   │   │   │   │           │   └─{chromium-browse},8290
  │   │   │   │   │           ├─chromium-browse,16745
  │   │   │   │   │           │   ├─{chromium-browse},16750
  │   │   │   │   │           │   ├─{chromium-browse},16760
  │   │   │   │   │           │   ├─{chromium-browse},16761
  │   │   │   │   │           │   ├─{chromium-browse},16762
  │   │   │   │   │           │   ├─{chromium-browse},16767
  │   │   │   │   │           │   ├─{chromium-browse},16768
  │   │   │   │   │           │   ├─{chromium-browse},17690
  │   │   │   │   │           │   ├─{chromium-browse},19623
  │   │   │   │   │           │   └─{chromium-browse},19624
  │   │   │   │   │           ├─chromium-browse,22518
  │   │   │   │   │           │   ├─{chromium-browse},22519
  │   │   │   │   │           │   ├─{chromium-browse},22583
  │   │   │   │   │           │   ├─{chromium-browse},22584
  │   │   │   │   │           │   ├─{chromium-browse},22586
  │   │   │   │   │           │   ├─{chromium-browse},22587
  │   │   │   │   │           │   └─{chromium-browse},22596
  │   │   │   │   │           ├─chromium-browse,22561
  │   │   │   │   │           │   ├─{chromium-browse},22567
  │   │   │   │   │           │   ├─{chromium-browse},22597
  │   │   │   │   │           │   ├─{chromium-browse},22598
  │   │   │   │   │           │   ├─{chromium-browse},22599
  │   │   │   │   │           │   ├─{chromium-browse},22602
  │   │   │   │   │           │   └─{chromium-browse},22620
  │   │   │   │   │           ├─chromium-browse,22590
  │   │   │   │   │           │   ├─{chromium-browse},22594
  │   │   │   │   │           │   ├─{chromium-browse},22616
  │   │   │   │   │           │   ├─{chromium-browse},22617
  │   │   │   │   │           │   ├─{chromium-browse},22618
  │   │   │   │   │           │   ├─{chromium-browse},22619
  │   │   │   │   │           │   ├─{chromium-browse},11172
  │   │   │   │   │           │   └─{chromium-browse},9998
  │   │   │   │   │           ├─chromium-browse,22607
  │   │   │   │   │           │   ├─{chromium-browse},22611
  │   │   │   │   │           │   ├─{chromium-browse},22633
  │   │   │   │   │           │   ├─{chromium-browse},22637
  │   │   │   │   │           │   ├─{chromium-browse},22640
  │   │   │   │   │           │   ├─{chromium-browse},22643
  │   │   │   │   │           │   ├─{chromium-browse},13683
  │   │   │   │   │           │   └─{chromium-browse},13684
  │   │   │   │   │           └─chromium-browse,22612
  │   │   │   │   │               ├─{chromium-browse},22613
  │   │   │   │   │               ├─{chromium-browse},22635
  │   │   │   │   │               ├─{chromium-browse},22641
  │   │   │   │   │               ├─{chromium-browse},22642
  │   │   │   │   │               ├─{chromium-browse},22644
  │   │   │   │   │               ├─{chromium-browse},12275
  │   │   │   │   │               └─{chromium-browse},13079
  │   │   │   │   ├─chromium-browse,22464
  │   │   │   │   │   ├─chromium-browse,22520                                                                                   ...
  │   │   │   │   │   ├─{chromium-browse},22523
  │   │   │   │   │   └─{chromium-browse},22527
  │   │   │   │   ├─{chromium-browse},22434
  │   │   │   │   ├─{chromium-browse},22441
  │   │   │   │   ├─{chromium-browse},22442
  │   │   │   │   ├─{chromium-browse},22443
  │   │   │   │   ├─{chromium-browse},22444
  │   │   │   │   ├─{chromium-browse},22445
  │   │   │   │   ├─{chromium-browse},22448
  │   │   │   │   ├─{chromium-browse},22449
  │   │   │   │   ├─{chromium-browse},22450
  │   │   │   │   ├─{chromium-browse},22451
  │   │   │   │   ├─{chromium-browse},22452
  │   │   │   │   ├─{chromium-browse},22453
  │   │   │   │   ├─{chromium-browse},22454
  │   │   │   │   ├─{chromium-browse},22455
  │   │   │   │   ├─{chromium-browse},22456
  │   │   │   │   ├─{chromium-browse},22457
  │   │   │   │   ├─{chromium-browse},22458
  │   │   │   │   ├─{chromium-browse},22459
  │   │   │   │   ├─{chromium-browse},22460
  │   │   │   │   ├─{chromium-browse},22462
  │   │   │   │   ├─{chromium-browse},22463
  │   │   │   │   ├─{chromium-browse},22465
  │   │   │   │   ├─{chromium-browse},22466
  │   │   │   │   ├─{chromium-browse},22467
  │   │   │   │   ├─{chromium-browse},22480
  │   │   │   │   ├─{chromium-browse},22489
  │   │   │   │   ├─{chromium-browse},22491
  │   │   │   │   ├─{chromium-browse},22492
  │   │   │   │   ├─{chromium-browse},22494
  │   │   │   │   ├─{chromium-browse},22517
  │   │   │   │   ├─{chromium-browse},22533
  │   │   │   │   ├─{chromium-browse},22582
  │   │   │   │   ├─{chromium-browse},22595
  │   │   │   │   ├─{chromium-browse},22743
  │   │   │   │   ├─{chromium-browse},22803
  │   │   │   │   ├─{chromium-browse},22814
  │   │   │   │   ├─{chromium-browse},27011
  │   │   │   │   ├─{chromium-browse},2718
  │   │   │   │   ├─{chromium-browse},2719
  │   │   │   │   └─{chromium-browse},11715
  │   │   │   ├─conky,6029 -q -d -c /home/kashu/.conkyrc
  │   │   │   │   ├─{conky},6030
  │   │   │   │   ├─{conky},6031
  │   │   │   │   ├─{conky},6032
  │   │   │   │   ├─{conky},6033
  │   │   │   │   ├─{conky},6034
  │   │   │   │   ├─{conky},6035
  │   │   │   │   ├─{conky},6036
  │   │   │   │   ├─{conky},6037
  │   │   │   │   ├─{conky},6038
  │   │   │   │   └─{conky},6039
  │   │   │   ├─dbus-daemon,2144 --fork --session --address=unix:abstract=/tmp/dbus-xO3T2Ut8Yo
  │   │   │   ├─dbus-daemon,2264 --fork --print-pid 5 --print-address 7 --config-file /usr/share/fcitx/dbus/daemon.conf
  │   │   │   ├─dconf-service,2767
  │   │   │   │   ├─{dconf-service},2768
  │   │   │   │   └─{dconf-service},2769
  │   │   │   ├─evolution-calen,2984
  │   │   │   │   ├─{evolution-calen},4282
  │   │   │   │   ├─{evolution-calen},4283
  │   │   │   │   ├─{evolution-calen},4284
  │   │   │   │   └─{evolution-calen},4285
  │   │   │   ├─evolution-sourc,2867
  │   │   │   │   ├─{evolution-sourc},2872
  │   │   │   │   └─{evolution-sourc},2881
  │   │   │   ├─fcitx,2258
  │   │   │   ├─fcitx-dbus-watc,2279 unix:abstract=/tmp/dbus-l2ofG1miFK,guid=5c3c78605ff14c5e7d96e14955502ac9 2264
  │   │   │   ├─gconfd-2,2959
  │   │   │   ├─gnome-keyring-d,2164 --start --components pkcs11,secrets
  │   │   │   │   ├─{gnome-keyring-d},2168
  │   │   │   │   ├─{gnome-keyring-d},2169
  │   │   │   │   ├─{gnome-keyring-d},2172
  │   │   │   │   ├─{gnome-keyring-d},2180
  │   │   │   │   └─{gnome-keyring-d},6028
  │   │   │   ├─gnome-session,2225 --session=ubuntu
  │   │   │   │   ├─compiz,2783
  │   │   │   │   │   ├─{compiz},2789
  │   │   │   │   │   ├─{compiz},2874
  │   │   │   │   │   ├─{compiz},2877
  │   │   │   │   │   ├─{compiz},4375
  │   │   │   │   │   ├─{compiz},4376
  │   │   │   │   │   ├─{compiz},4377
  │   │   │   │   │   └─{compiz},4378
  │   │   │   │   ├─indicator-multi,2915
  │   │   │   │   │   ├─{indicator-multi},2924
  │   │   │   │   │   └─{indicator-multi},2927
  │   │   │   │   ├─nautilus,2925 -n
  │   │   │   │   │   ├─{nautilus},2936
  │   │   │   │   │   ├─{nautilus},2942
  │   │   │   │   │   └─{nautilus},2955
  │   │   │   │   ├─nm-applet,2922
  │   │   │   │   │   ├─{nm-applet},2937
  │   │   │   │   │   └─{nm-applet},2939
  │   │   │   │   ├─polkit-gnome-au,2919
  │   │   │   │   │   ├─{polkit-gnome-au},2932
  │   │   │   │   │   └─{polkit-gnome-au},2934
  │   │   │   │   ├─unity-fallback-,2917
  │   │   │   │   │   ├─{unity-fallback-},2926
  │   │   │   │   │   └─{unity-fallback-},2928
  │   │   │   │   ├─{gnome-session},2420
  │   │   │   │   ├─{gnome-session},2423
  │   │   │   │   └─{gnome-session},2447
  │   │   │   ├─gnome-terminal,23780
  │   │   │   │   ├─bash,817
  │   │   │   │   ├─bash,17087
  │   │   │   │   │   └─sudo,18149,root tcpdump -i eth0 -n -p not arp and icmp
  │   │   │   │   │       └─tcpdump,18150 -i eth0 -n -p not arp and icmp
  │   │   │   │   ├─bash,23788
  │   │   │   │   │   └─pstree,22537 -pauU
  │   │   │   │   ├─bash,29274
  │   │   │   │   ├─gnome-pty-helpe,23787
  │   │   │   │   ├─{gnome-terminal},23783
  │   │   │   │   ├─{gnome-terminal},23784
  │   │   │   │   └─{gnome-terminal},23786
  │   │   │   ├─gvfs-afc-volume,2966
  │   │   │   │   ├─{gvfs-afc-volume},2967
  │   │   │   │   └─{gvfs-afc-volume},2969
  │   │   │   ├─gvfs-gphoto2-vo,2975
  │   │   │   │   └─{gvfs-gphoto2-vo},2977
  │   │   │   ├─gvfs-mtp-volume,2971
  │   │   │   │   └─{gvfs-mtp-volume},2973
  │   │   │   ├─gvfs-udisks2-vo,2945
  │   │   │   │   ├─{gvfs-udisks2-vo},2947
  │   │   │   │   └─{gvfs-udisks2-vo},2963
  │   │   │   ├─gvfsd,2286
  │   │   │   │   └─{gvfsd},2288
  │   │   │   ├─gvfsd-burn,3476 --spawner :1.17 /org/gtk/gvfs/exec_spaw/1
  │   │   │   │   ├─{gvfsd-burn},3507
  │   │   │   │   └─{gvfsd-burn},3548
  │   │   │   ├─gvfsd-fuse,2291 /run/user/1000/gvfs -f -o big_writes
  │   │   │   │   ├─{gvfsd-fuse},2294
  │   │   │   │   ├─{gvfsd-fuse},2295
  │   │   │   │   ├─{gvfsd-fuse},2296
  │   │   │   │   └─{gvfsd-fuse},2297
  │   │   │   ├─gvfsd-metadata,4314
  │   │   │   │   └─{gvfsd-metadata},4315
  │   │   │   ├─gvfsd-trash,2986 --spawner :1.17 /org/gtk/gvfs/exec_spaw/0
  │   │   │   │   ├─{gvfsd-trash},2987
  │   │   │   │   ├─{gvfsd-trash},2988
  │   │   │   │   └─{gvfsd-trash},10877
  │   │   │   ├─hud-service,2221
  │   │   │   │   ├─{hud-service},2995
  │   │   │   │   ├─{hud-service},2996
  │   │   │   │   └─{hud-service},3929
  │   │   │   ├─indicator-appli,2845
  │   │   │   │   └─{indicator-appli},2865
  │   │   │   ├─indicator-bluet,2828
  │   │   │   │   ├─{indicator-bluet},2830
  │   │   │   │   └─{indicator-bluet},2841
  │   │   │   ├─indicator-datet,2833
  │   │   │   │   ├─{indicator-datet},2839
  │   │   │   │   ├─{indicator-datet},2861
  │   │   │   │   ├─{indicator-datet},2864
  │   │   │   │   ├─{indicator-datet},2869
  │   │   │   │   └─{indicator-datet},2982
  │   │   │   ├─indicator-keybo,2814 --use-gtk
  │   │   │   │   ├─{indicator-keybo},2820
  │   │   │   │   └─{indicator-keybo},2821
  │   │   │   ├─indicator-power,2829
  │   │   │   │   ├─{indicator-power},2832
  │   │   │   │   └─{indicator-power},2834
  │   │   │   ├─indicator-sessi,2844
  │   │   │   │   ├─{indicator-sessi},2846
  │   │   │   │   └─{indicator-sessi},2857
  │   │   │   ├─indicator-sound,2835
  │   │   │   │   ├─{indicator-sound},2849
  │   │   │   │   ├─{indicator-sound},2859
  │   │   │   │   └─{indicator-sound},2880
  │   │   │   ├─notify-osd,2332
  │   │   │   │   ├─{notify-osd},2349
  │   │   │   │   └─{notify-osd},2351
  │   │   │   ├─pulseaudio,2630 --start --log-target=syslog
  │   │   │   │   ├─{pulseaudio},2771
  │   │   │   │   └─{pulseaudio},2773
  │   │   │   ├─python3,10756 /usr/bin/bcloud-gui
  │   │   │   │   ├─{python3},10759
  │   │   │   │   ├─{python3},10760
  │   │   │   │   └─{python3},10763
  │   │   │   ├─unity-panel-ser,2231
  │   │   │   │   ├─{unity-panel-ser},2281
  │   │   │   │   └─{unity-panel-ser},2284
  │   │   │   ├─unity-settings-,2217
  │   │   │   │   ├─syndaemon,2770 -i 1.0 -t -K -R
  │   │   │   │   ├─{unity-settings-},2298
  │   │   │   │   ├─{unity-settings-},2299
  │   │   │   │   └─{unity-settings-},2418
  │   │   │   ├─upstart-dbus-br,2236 --daemon --session --user --bus-name session
  │   │   │   ├─upstart-dbus-br,2238 --daemon --system --user --bus-name system
  │   │   │   ├─upstart-event-b,2155
  │   │   │   ├─upstart-file-br,2240 --daemon --user
  │   │   │   └─window-stack-br,2161
  │   │   └─{lightdm},1844
  │   ├─{lightdm},1803
  │   └─{lightdm},1818
  ├─logger,1252 -p daemon.err -t /etc/init.d/mysql -i
  ├─mysqld_safe,1251 /usr/bin/mysqld_safe
  │   └─mysqld,1612,mysql --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql...
  │       ├─{mysqld},1614
  │       ├─{mysqld},1615
  │       ├─{mysqld},1616
  │       ├─{mysqld},1617
  │       ├─{mysqld},1618
  │       ├─{mysqld},1619
  │       ├─{mysqld},1620
  │       ├─{mysqld},1621
  │       ├─{mysqld},1622
  │       ├─{mysqld},1623
  │       ├─{mysqld},1775
  │       ├─{mysqld},1776
  │       ├─{mysqld},1777
  │       ├─{mysqld},1778
  │       ├─{mysqld},1779
  │       ├─{mysqld},1780
  │       ├─{mysqld},1832
  │       ├─{mysqld},1833
  │       ├─{mysqld},1867
  │       └─{mysqld},23534
  ├─nginx,1149
  │   ├─nginx,1150,www-data                           
  │   ├─nginx,1151,www-data                           
  │   ├─nginx,1152,www-data                           
  │   └─nginx,1153,www-data                           
  ├─php5-fpm,1781                    
  │   ├─php5-fpm,1784,www-data                                                       
  │   ├─php5-fpm,1785,www-data                                                       
  │   └─php5-fpm,23538,www-data                                                       
  ├─polkitd,828 --no-debug
  │   ├─{polkitd},893
  │   └─{polkitd},894
  ├─preload,3029 -s /var/lib/preload/preload.state
  ├─rsyslogd,850,syslog
  │   ├─{rsyslogd},853
  │   ├─{rsyslogd},854
  │   └─{rsyslogd},855
  ├─rtkit-daemon,2635,rtkit
  │   ├─{rtkit-daemon},2642
  │   └─{rtkit-daemon},2643
  ├─systemd-logind,866
  ├─systemd-udevd,333 --daemon
  ├─udisksd,2949 --no-debug
  │   ├─{udisksd},2950
  │   ├─{udisksd},2952
  │   ├─{udisksd},2953
  │   └─{udisksd},2962
  ├─upowerd,2302
  │   ├─{upowerd},2303
  │   └─{upowerd},2304
  ├─upstart-file-br,773 --daemon
  ├─upstart-socket-,558 --daemon
  ├─upstart-udev-br,326 --daemon
  ├─vmnet-bridge,2039 -s 6 -d /var/run/vmnet-bridge-0.pid -n 0
  ├─vmnet-dhcpd,2265 -s 6 -cf /etc/vmware/vmnet1/dhcpd/dhcpd.conf -lf /etc/vmware/vmnet1/dhcpd/dhcpd.leases -pf/var/run/vmnet-dhcpd
  ├─vmnet-dhcpd,2305 -s 6 -cf /etc/vmware/vmnet8/dhcpd/dhcpd.conf -lf /etc/vmware/vmnet8/dhcpd/dhcpd.leases -pf/var/run/vmnet-dhcpd
  ├─vmnet-natd,2268 -s 6 -m /etc/vmware/vmnet8/nat.mac -c /etc/vmware/vmnet8/nat/nat.conf
  ├─vmnet-netifup,2200 -s 6 -d /var/run/vmnet-netifup-vmnet1.pid /dev/vmnet1 vmnet1
  ├─vmnet-netifup,2271 -s 6 -d /var/run/vmnet-netifup-vmnet8.pid /dev/vmnet8 vmnet8
  ├─vmware-authdlau,2326
  ├─vmware-usbarbit,2444
  ├─vmware-vmblock-,2027 -o subtype=vmware-vmblock,default_permissions,allow_other /var/run/vmblock-fuse
  │   ├─{vmware-vmblock-},2028
  │   └─{vmware-vmblock-},2029
  ├─winbindd,5859 -F
  │   └─winbindd,5913 -F
  └─wpa_supplicant,4461 -B -P /run/sendsigs.omit.d/wpasupplicant.pid -u -s -O /var/run/wpa_supplicant
