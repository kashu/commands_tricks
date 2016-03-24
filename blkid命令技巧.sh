The  blkid  program  is the command-line interface to working with the libblkid(3) library.  It can determine the type of content (e.g. filesystem or swap) that a block device holds, and also attributes (tokens, NAME=value pairs) from the content metadata (e.g. LABEL or UUID fields).
blkid has two main forms of operation: either searching for a device with a specific NAME=value pair, or displaying NAME=value pairs for one or more specified devices.

blkid - locate/print block device attributes


$ sudo blkid
/dev/sda1: UUID="7cc07298-ea6f-423b-bd3a-d2eab90be220" TYPE="ext4" 
/dev/sda2: UUID="4fe1K7-1DSG-SQsO-tlcv-3saU-18ah-kpWnww" TYPE="LVM2_member" 
/dev/sdb1: UUID="8a5b3d84-51d5-4979-a346-f36b96a962de" TYPE="ext4" 
/dev/mapper/lvmVG-lvswap: UUID="74c1731c-42b3-4beb-ab24-3ef32c4bc30c" TYPE="swap" 
/dev/mapper/lvmVG-lvroot: UUID="890f4e5b-20e4-4b41-af5a-4de833e7be3c" TYPE="ext4" 
/dev/mapper/lvmVG-lvhome: UUID="10180dc0-36a8-412f-bf45-4306b9fb3df3" TYPE="ext4" 

#查看文件系统是EXT4的所有UUID
$ sudo blkid -t TYPE=ext4
/dev/sda1: UUID="7cc07298-ea6f-423b-bd3a-d2eab90be220" TYPE="ext4" 
/dev/sdb1: UUID="8a5b3d84-51d5-4979-a346-f36b96a962de" TYPE="ext4" 
/dev/mapper/lvmVG-lvroot: UUID="890f4e5b-20e4-4b41-af5a-4de833e7be3c" TYPE="ext4" 
/dev/mapper/lvmVG-lvhome: UUID="10180dc0-36a8-412f-bf45-4306b9fb3df3" TYPE="ext4"

#查看指定分区的UUID
$ sudo blkid /dev/sd{a..b}1
/dev/sda1: UUID="7cc07298-ea6f-423b-bd3a-d2eab90be220" TYPE="ext4" 
/dev/sdb1: UUID="8a5b3d84-51d5-4979-a346-f36b96a962de" TYPE="ext4"

#通过-po udev或-po full查看详细信息
$ sudo blkid -po udev /dev/sda1
ID_FS_UUID=7cc07298-ea6f-423b-bd3a-d2eab90be220
ID_FS_UUID_ENC=7cc07298-ea6f-423b-bd3a-d2eab90be220
ID_FS_VERSION=1.0
ID_FS_TYPE=ext4
ID_FS_USAGE=filesystem
ID_PART_ENTRY_SCHEME=dos
ID_PART_ENTRY_TYPE=0x83
ID_PART_ENTRY_FLAGS=0x80
ID_PART_ENTRY_NUMBER=1
ID_PART_ENTRY_OFFSET=2048
ID_PART_ENTRY_SIZE=4194304
ID_PART_ENTRY_DISK=8:0

$ sudo blkid -po full /dev/sda1
/dev/sda1: UUID="7cc07298-ea6f-423b-bd3a-d2eab90be220" VERSION="1.0" TYPE="ext4" USAGE="filesystem" PART_ENTRY_SCHEME="dos" PART_ENTRY_TYPE="0x83" PART_ENTRY_FLAGS="0x80" PART_ENTRY_NUMBER="1" PART_ENTRY_OFFSET="2048" PART_ENTRY_SIZE="4194304" PART_ENTRY_DISK="8:0" 
