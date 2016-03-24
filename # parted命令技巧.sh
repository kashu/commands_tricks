查看sdb硬盘的分区情况：
[root@kashu ~]# parted /dev/sdb p
Model: VMware, VMware Virtual S (scsi)
Disk /dev/sdb: 53.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start  End  Size  Type  File system  Flags

Information: Don't forget to update /etc/fstab, if necessary.             

新增一个10GB的主分区：
[root@kashu ~]# parted /dev/sdb mkpart p ext3 0 10G
Information: Don't forget to update /etc/fstab, if necessary.             

查看sdb硬盘的分区情况：
[root@kashu ~]# parted /dev/sdb p
Model: VMware, VMware Virtual S (scsi)
Disk /dev/sdb: 53.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      32.3kB  10.0GB  10.0GB  primary                    

Information: Don't forget to update /etc/fstab, if necessary.             

新增一个扩展分区，并把所有剩余空间分配到扩展分区：
[root@kashu ~]# parted /dev/sdb mkpart e 10G 53.7GB
Information: Don't forget to update /etc/fstab, if necessary.             

查看sdb硬盘的分区情况：
[root@kashu ~]# parted /dev/sdb p
Model: VMware, VMware Virtual S (scsi)
Disk /dev/sdb: 53.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type      File system  Flags
 1      32.3kB  10.0GB  10.0GB  primary                     
 2      10.0GB  53.7GB  43.7GB  extended               lba  

Information: Don't forget to update /etc/fstab, if necessary.             

新增一个15GB的逻辑分区：
[root@kashu ~]# parted /dev/sdb mkpart l ext3 10G 25G
Information: Don't forget to update /etc/fstab, if necessary.             

查看sdb硬盘的分区情况：
[root@kashu ~]# parted /dev/sdb p
Model: VMware, VMware Virtual S (scsi)
Disk /dev/sdb: 53.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type      File system  Flags
 1      32.3kB  10.0GB  10.0GB  primary                     
 2      10.0GB  53.7GB  43.7GB  extended               lba  
 5      10.0GB  25.0GB  15.0GB  logical                     

Information: Don't forget to update /etc/fstab, if necessary.             

用fdisk查看一下sdb的分区情况：
[root@kashu ~]# fdisk -l /dev/sdb
Disk /dev/sdb: 53.6 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        1216     9767488+  83  Linux
/dev/sdb2            1217        6527    42660607+   f  W95 Ext'd (LBA)
/dev/sdb5            1217        3039    14643216   83  Linux

删除分区号为5的分区（第一个逻辑分区）：
[root@kashu ~]# parted /dev/sdb rm 5
Information: Don't forget to update /etc/fstab, if necessary.             

查看sdb硬盘的分区情况：
[root@kashu ~]# parted /dev/sdb p
Model: VMware, VMware Virtual S (scsi)
Disk /dev/sdb: 53.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type      File system  Flags
 1      32.3kB  10.0GB  10.0GB  primary                     
 2      10.0GB  53.7GB  43.7GB  extended               lba  

Information: Don't forget to update /etc/fstab, if necessary.             
