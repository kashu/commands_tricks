badblocks is the command or utility in linux like operating system which can scan or test our hard disk and external drivefor bad sectors. Bad sectors or bad blocks is the space of the disk which can't be used due to the permanent damage or OS is unable to access it. 

Badblocks  command will detect all bad blocks(bad sectors)  on our hard disk and save them in a text file so that we can use it with e2fsck to configure  Operating System(OS) to not store our data on these damaged sectors.

Step:1 Use fdisk command to identify your hard drive info 

# sudo fdisk -l 

Step:2  Scan your hard drive for Bad Sectors or Bad Blocks 

# sudo badblocks -v /dev/sdb > /tmp/bad-blocks.txt

Just replace “/dev/sdb” with your own hard disk / partition. When we execute above command  a text file “bad-blocks” will be created under /tmp , which will contains all bad blocks.

Example :

badblocks

Step:3 Inform OS not to use bad blocks  for storing data

Once the scanning is completed , if the bad sectors are reported , then use file “bad-blocks.txt” with e2fsck command  and force OS not to use these bad blocks for storing data.

# sudo e2fsck -l /tmp/bad-blocks.txt  /dev/sdb

Note : Before running e2fsck command , you just make sure the drive is not mounted.

For any futher help on badblocks & e2fsck command , read their man pages 

# man badblocks
# man e2fsck 
