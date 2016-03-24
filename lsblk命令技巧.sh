Usage:
 lsblk [options] [<device> ...]

Options:
 -a, --all            print all devices
 -b, --bytes          print SIZE in bytes rather than in human readable format
 -d, --nodeps         don't print slaves or holders
 -D, --discard        print discard capabilities
 -e, --exclude <list> exclude devices by major number (default: RAM disks)
 -f, --fs             output info about filesystems
 -h, --help           usage information (this)
 -i, --ascii          use ascii characters only
 -m, --perms          output info about permissions
 -l, --list           use list format ouput
 -n, --noheadings     don't print headings
 -o, --output <list>  output columns
 -P, --pairs          use key="value" output format
 -r, --raw            use raw output format
 -t, --topology       output info about topology



$ lsblk
NAME                    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda                       8:0    0 465.8G  0 disk 
├─sda1                    8:1    0     2G  0 part /boot
└─sda2                    8:2    0 463.8G  0 part 
  ├─lvmVG-lvswap (dm-0) 252:0    0     1G  0 lvm  [SWAP]
  ├─lvmVG-lvroot (dm-1) 252:1    0    50G  0 lvm  /
  └─lvmVG-lvhome (dm-2) 252:2    0 412.8G  0 lvm  /home
sdb                       8:16   0 298.1G  0 disk 
└─sdb1                    8:17   0 298.1G  0 part 

#显示权限信息
$ lsblk -m
NAME                      SIZE OWNER GROUP MODE
sda                     465.8G root  disk  brw-rw----
├─sda1                      2G root  disk  brw-rw----
└─sda2                  463.8G root  disk  brw-rw----
  ├─lvmVG-lvswap (dm-0)     1G root  disk  brw-rw----
  ├─lvmVG-lvroot (dm-1)    50G root  disk  brw-rw----
  └─lvmVG-lvhome (dm-2) 412.8G root  disk  brw-rw----
sdb                     298.1G root  disk  brw-rw----
└─sdb1                  298.1G root  disk  brw-rw----	
