linux下快速删除大量文件
 
假如你要在linux下删除大量文件，比如100万、1000万，像/var/spool/clientmqueue/的mail邮件， 
 
像/usr/local/nginx/proxy_temp的nginx缓存等，那么rm -rf *可能就不好使了。 
rsync提供了一些跟删除相关的参数   www.2cto.com  
rsync --help | grep delete 
     --del                   an alias for --delete-during 
     --delete                delete files that don't exist on the sending side 
     --delete-before         receiver deletes before transfer (default) 
     --delete-during         receiver deletes during transfer, not before 
     --delete-after          receiver deletes after transfer, not before 
     --delete-excluded       also delete excluded files on the receiving side 
     --ignore-errors         delete even if there are I/O errors 
     --max-delete=NUM        don't delete more than NUM files 
 
其中--delete-before    接收者在传输之前进行删除操作 
 
可以用来清空目录或文件，如下： 
1、先建立一个空目录 
mkdir /data/blank 

2、用rsync删除目标目录 (注意前面那个路径末尾一定要加/)
rsync --delete-before -d /data/blank/ /var/spool/clientmqueue/ 

这样目标目录很快就被清空了 
 
又假如你有一些特别大的文件要删除，比如nohup.out这样的实时更新的文件，动辄都是几十个G上百G的，也可   www.2cto.com  
 
以用rsync来清空大文件，而且效率比较高 
1、创建空文件 
touch /data/blank.txt 
2、用rsync清空文件 
rsync -a --delete-before --progress --stats /root/blank.txt /root/nohup.out 
building file list ... 
1 file to consider 
blank.txt 
           0 100%    0.00kB/s    0:00:00 (xfer#1, to-check=0/1) 
 
Number of files: 1 
Number of files transferred: 1 
Total file size: 0 bytes 
Total transferred file size: 0 bytes 
Literal data: 0 bytes 
Matched data: 0 bytes 
File list size: 27 
File list generation time: 0.006 seconds 
File list transfer time: 0.000 seconds 
Total bytes sent: 73 
Total bytes received: 31 
sent 73 bytes  received 31 bytes  208.00 bytes/sec 
total size is 0  speedup is 0.00 
 
tips： 
当SRC和DEST文件性质不一致时将会报错 
当SRC和DEST性质都为文件【f】时，意思是清空文件内容而不是删除文件 
当SRC和DEST性质都为目录【d】时，意思是删除该目录下的所有文件，使其变为空目录 
最重要的是，它的处理速度相当快，处理几个G的文件也就是秒级的事 
最核心的内容是：rsync实际上用的就是替换原理 
