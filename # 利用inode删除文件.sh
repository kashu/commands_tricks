有时，你会有这样的困惑，删除某个文件删除不了。 这可能是因为文件名为中文，在linux命令行下不能正常显示。

如： ls 看当前目录下有文件名为这样的文件
-=?+.jpg +-?+.jpg

此时使用ls rm mv等命令都会失效，怎么办？
先查其inode数。
ls -i 
6340540 -=?+.jpg 6340539 +-?+.jpg
左边为inode数。删除办法为
find . -inum 6340540 |xargs rm
find . -inum 6340539|xargs rm
