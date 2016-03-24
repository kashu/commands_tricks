rsync stands for remote sync.

rsync is used to perform the backup operation in UNIX / Linux.

rsync utility is used to synchronize the files and directories from one location to another in an effective way. Backup location could be on local server or on remote server.

Important features of rsync
Speed: First time, rsync replicates the whole content between the source and destination directories. Next time, rsync transfers only the changed blocks or bytes to the destination location, which makes the transfer really fast.
Security: rsync allows encryption of data using ssh protocol during transfer.
Less Bandwidth: rsync uses compression and decompression of data block by block at the sending and receiving end respectively. So the bandwidth used by rsync will be always less compared to other file transfer protocols.
Privileges: No special privileges are required to install and execute rsync
Syntax
$ rsync options source destination
Source and destination could be either local or remote. In case of remote, specify the login name, remote server name and location.

Example 1. Synchronize Two Directories in a Local Server
To sync two directories in a local computer, use the following rsync -zvr command.

$ rsync -zvr /var/opt/installation/inventory/ /root/temp
building file list ... done
sva.xml
svB.xml
.
sent 26385 bytes  received 1098 bytes  54966.00 bytes/sec
total size is 44867  speedup is 1.63
$
In the above rsync example:

-z is to enable compression
-v verbose
-r indicates recursive
Now let us see the timestamp on one of the files that was copied from source to destination. As you see below, rsync didn’t preserve timestamps during sync.

$ ls -l /var/opt/installation/inventory/sva.xml /root/temp/sva.xml
-r--r--r-- 1 bin  bin  949 Jun 18  2009 /var/opt/installation/inventory/sva.xml
-r--r--r-- 1 root bin  949 Sep  2  2009 /root/temp/sva.xml
Example 2. Preserve timestamps during Sync using rsync -a
rsync option -a indicates archive mode. -a option does the following,

Recursive mode
Preserves symbolic links
Preserves permissions
Preserves timestamp
Preserves owner and group
Now, executing the same command provided in example 1 (But with the rsync option -a) as shown below:

$ rsync -azv /var/opt/installation/inventory/ /root/temp/
building file list ... done
./
sva.xml
svB.xml
.
sent 26499 bytes  received 1104 bytes  55206.00 bytes/sec
total size is 44867  speedup is 1.63
$
As you see below, rsync preserved timestamps during sync.

$ ls -l /var/opt/installation/inventory/sva.xml /root/temp/sva.xml
-r--r--r-- 1 root  bin  949 Jun 18  2009 /var/opt/installation/inventory/sva.xml
-r--r--r-- 1 root  bin  949 Jun 18  2009 /root/temp/sva.xml
Example 3. Synchronize Only One File
To copy only one file, specify the file name to rsync command, as shown below.

$ rsync -v /var/lib/rpm/Pubkeys /root/temp/
Pubkeys

sent 42 bytes  received 12380 bytes  3549.14 bytes/sec
total size is 12288  speedup is 0.99
Example 4. Synchronize Files From Local to Remote
rsync allows you to synchronize files/directories between the local and remote system.

$ rsync -avz /root/temp/ thegeekstuff@192.168.200.10:/home/thegeekstuff/temp/
Password:
building file list ... done
./
rpm/
rpm/Basenames
rpm/Conflictname

sent 15810261 bytes  received 412 bytes  2432411.23 bytes/sec
total size is 45305958  speedup is 2.87
While doing synchronization with the remote server, you need to specify username and ip-address of the remote server. You should also specify the destination directory on the remote server. The format is username@machinename:path

As you see above, it asks for password while doing rsync from local to remote server.

Sometimes you don’t want to enter the password while backing up files from local to remote server. For example, If you have a backup shell script, that copies files from local to remote server using rsync, you need the ability to rsync without having to enter the password.

To do that, setup ssh password less login as we explained earlier.

Example 5. Synchronize Files From Remote to Local
When you want to synchronize files from remote to local, specify remote path in source and local path in target as shown below.

$ rsync -avz thegeekstuff@192.168.200.10:/var/lib/rpm /root/temp
Password:
receiving file list ... done
rpm/
rpm/Basenames
.
sent 406 bytes  received 15810230 bytes  2432405.54 bytes/sec
total size is 45305958  speedup is 2.87
Example 6. Remote shell for Synchronization
rsync allows you to specify the remote shell which you want to use. You can use rsync ssh to enable the secured remote connection.

Use rsync -e ssh to specify which remote shell to use. In this case, rsync will use ssh.

$ rsync -avz -e ssh thegeekstuff@192.168.200.10:/var/lib/rpm /root/temp
Password:
receiving file list ... done
rpm/
rpm/Basenames

sent 406 bytes  received 15810230 bytes  2432405.54 bytes/sec
total size is 45305958  speedup is 2.87
Example 7. Do Not Overwrite the Modified Files at the Destination
In a typical sync situation, if a file is modified at the destination, we might not want to overwrite the file with the old file from the source.

Use rsync -u option to do exactly that. (i.e do not overwrite a file at the destination, if it is modified). In the following example, the file called Basenames is already modified at the destination. So, it will not be overwritten with rsync -u.

$ ls -l /root/temp/Basenames
total 39088
-rwxr-xr-x 1 root root        4096 Sep  2 11:35 Basenames

$ rsync -avzu thegeekstuff@192.168.200.10:/var/lib/rpm /root/temp
Password:
receiving file list ... done
rpm/

sent 122 bytes  received 505 bytes  114.00 bytes/sec
total size is 45305958  speedup is 72258.31

$ ls -lrt
total 39088
-rwxr-xr-x 1 root root        4096 Sep  2 11:35 Basenames
Example 8. Synchronize only the Directory Tree Structure (not the files)
Use rsync -d option to synchronize only directory tree from source to the destination. The below example, synchronize only directory tree in recursive manner, not the files in the directories.

$ rsync -v -d thegeekstuff@192.168.200.10:/var/lib/ .
Password:
receiving file list ... done
logrotate.status
CAM/
YaST2/
acpi/

sent 240 bytes  received 1830 bytes  318.46 bytes/sec
total size is 956  speedup is 0.46
Example 9. View the rsync Progress during Transfer
When you use rsync for backup, you might want to know the progress of the backup. i.e how many files are copies, at what rate it is copying the file, etc.

rsync –progress option displays detailed progress of rsync execution as shown below.

$ rsync -avz --progress thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp/
Password:
receiving file list ...
19 files to consider
./
Basenames
     5357568 100%   14.98MB/s    0:00:00 (xfer#1, to-check=17/19)
Conflictname
       12288 100%   35.09kB/s    0:00:00 (xfer#2, to-check=16/19)
.
.
.
sent 406 bytes  received 15810211 bytes  2108082.27 bytes/sec
total size is 45305958  speedup is 2.87
You can also use rsnapshot utility (that uses rsync) to backup local linux server, or backup remote linux server.

Example 10. Delete the Files Created at the Target
If a file is not present at the source, but present at the target, you might want to delete the file at the target during rsync.

In that case, use –delete option as shown below. rsync delete option deletes files that are not there in source directory.

# Source and target are in sync. Now creating new file at the target.
$ > new-file.txt

$ rsync -avz --delete thegeekstuff@192.168.200.10:/var/lib/rpm/ .
Password:
receiving file list ... done
deleting new-file.txt
./

sent 26 bytes  received 390 bytes  48.94 bytes/sec
total size is 45305958  speedup is 108908.55
Target has the new file called new-file.txt, when synchronize with the source with –delete option, it removed the file new-file.txt

Example 11. Do not Create New File at the Target
If you like, you can update (Sync) only the existing files at the target. In case source has new files, which is not there at the target, you can avoid creating these new files at the target. If you want this feature, use –existing option with rsync command.

First, add a new-file.txt at the source.

[/var/lib/rpm ]$ > new-file.txt
Next, execute the rsync from the target.

$ rsync -avz --existing root@192.168.1.2:/var/lib/rpm/ .
root@192.168.1.2's password:
receiving file list ... done
./

sent 26 bytes  received 419 bytes  46.84 bytes/sec
total size is 88551424  speedup is 198991.96
If you see the above output, it didn’t receive the new file new-file.txt

Example 12. View the Changes Between Source and Destination
This option is useful to view the difference in the files or directories between source and destination.

At the source:

$ ls -l /var/lib/rpm
-rw-r--r-- 1 root root  5357568 2010-06-24 08:57 Basenames
-rw-r--r-- 1 root root    12288 2008-05-28 22:03 Conflictname
-rw-r--r-- 1 root root  1179648 2010-06-24 08:57 Dirnames
At the destination:

$ ls -l /root/temp
-rw-r--r-- 1 root root    12288 May 28  2008 Conflictname
-rw-r--r-- 1 bin  bin   1179648 Jun 24 05:27 Dirnames
-rw-r--r-- 1 root root        0 Sep  3 06:39 Basenames
In the above example, between the source and destination, there are two differences. First, owner and group of the file Dirname differs. Next, size differs for the file Basenames.

Now let us see how rsync displays this difference. -i option displays the item changes.

$ rsync -avzi thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp/
Password:
receiving file list ... done
>f.st.... Basenames
.f....og. Dirnames

sent 48 bytes  received 2182544 bytes  291012.27 bytes/sec
total size is 45305958  speedup is 20.76
In the output it displays some 9 letters in front of the file name or directory name indicating the changes.

In our example, the letters in front of the Basenames (and Dirnames) says the following:

> specifies that a file is being transferred to the local host.
f represents that it is a file.
s represents size changes are there.
t represents timestamp changes are there.
o owner changed
g group changed.
Example 13. Include and Exclude Pattern during File Transfer
rsync allows you to give the pattern you want to include and exclude files or directories while doing synchronization.

$ rsync -avz --include 'P*' --exclude '*' thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp/
Password:
receiving file list ... done
./
Packages
Providename
Provideversion
Pubkeys

sent 129 bytes  received 10286798 bytes  2285983.78 bytes/sec
total size is 32768000  speedup is 3.19
In the above example, it includes only the files or directories starting with ‘P’ (using rsync include) and excludes all other files. (using rsync exclude ‘*’ )

Example 14. Do Not Transfer Large Files
You can tell rsync not to transfer files that are greater than a specific size using rsync –max-size option.

$ rsync -avz --max-size='100K' thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp/
Password:
receiving file list ... done
./
Conflictname
Group
Installtid
Name
Sha1header
Sigmd5
Triggername

sent 252 bytes  received 123081 bytes  18974.31 bytes/sec
total size is 45305958  speedup is 367.35
max-size=100K makes rsync to transfer only the files that are less than or equal to 100K. You can indicate M for megabytes and G for gigabytes.

Example 15. Transfer the Whole File
One of the main feature of rsync is that it transfers only the changed block to the destination, instead of sending the whole file.

If network bandwidth is not an issue for you (but CPU is), you can transfer the whole file, using rsync -W option. This will speed-up the rsync process, as it doesn’t have to perform the checksum at the source and destination.

#  rsync -avzW  thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp
Password:
receiving file list ... done
./
Basenames
Conflictname
Dirnames
Filemd5s
Group
Installtid
Name

sent 406 bytes  received 15810211 bytes  2874657.64 bytes/sec
total size is 45305958  speedup is 2.87

