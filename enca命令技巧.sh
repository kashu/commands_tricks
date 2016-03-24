中文版Windows里默认的文件格式是GBK(gb2312)，当然也可以保存为UTF-8的，最简单的方法是用记事本的“另存为”就可以做到。
为了与windows兼容，SecureCRT中文件编码的默认配置是”Default”，其实也就是GBK。如果我们将其更改为了”UTF-8″，那么我们查看从windows中scp过去的GBK文件就会变成乱码，需要进行转换，比较麻烦。
不过有时候我们也需要进行编码的转换，比如这次我这次在建立cacti的模板的时候使用了中文，apache默认是UTF-8的编码，所以记录到mysql数据库中的就是UTF-8的编码了(奇怪的是，在mysql中使用”set names utf-8″看不到正确的中文，需要使用”hex()”函数来看二进制，数一下字符数量，看是不是utf-8…..)。而当我使用批量添加主机的脚本来添加新服务器信息到数据库后，发现在网页中出现了乱码。原因是在cli中使用脚本的话，中文是使用GBK的格式保存到数据库中的。于是变成了很郁闷的情况，无论将浏览器编码设置为”UTF-8″还是”GB2312″，总会有一部分中文是乱码的。
解决的方法，不是将原来的模板的中文都转换成gb2312，就是要将以后添加的主机信息里面的中文转换成UTF-8。因为我比较喜欢UTF-8一点，所以我决定用后一种方法。
linux里面转换编码的方法很多，google了一下，一般的人都是用”iconv”命令来进行转换。但是由于我需要在脚本里面判断文件的编码，”iconv”就不太适用。其实Linux里面还有另一个能进行编码转换，并比”iconv”功能强大的”enca”。


debian中的安装:
aptitude install enca

使用方法：
enca -L zh file 检查文件的编码
enca -L zh -x UTF-8 file 将文件编码转换为"UTF-8"编码
enca -L zh -x UTF-8 < file1 > file2 如果不想覆盖原文件可以这样
除了有检查文件编码的功能以外，”enca”还有一个好处就是如果文件本来就是你要转换的那种编码，它不会报错，还是会print出结果来，而”iconv”则会报错。这对于脚本编写是比较方便的事情。


 
1. 使用VIM
使用命令 :set fileencoding 即可显示文件编码
如果你只是想查看其它编码格式的文件或者想解决用Vim查看文件乱码的问题，那么你可以在
~/.vimrc 文件中添加以下内容：
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936
这样，就可以让vim自动识别文件编码（可以自动识别UTF-8或者GBK编码的文件），其实就是依照fileencodings提供的编码列表尝试，如果没有找到合适的编码，就用latin-1(ASCII)编码打开。
2. 使用enca ( Extremely Naive Charset Analyser )
这个包，系统默认可能没有安装，需要安装。
使用方法：$enca filename
文件编码转换
1. 使用VIM
:set fileencoding=utf-8
保存退出。
2. 使用enca包工具enconv转换文件编码
比如要将一个GBK编码的文件转换成UTF-8编码，操作如下：
enconv -L zh_CN -x UTF-8 filename
3. iconv 转换，（iconv属于glibc-common包，一般系统都有）iconv的命令格式如下：
iconv -f encoding -t encoding inputfile
比如将一个UTF-8 编码的文件转换成GBK编码
iconv -f GBK -t UTF-8 file1 -o file2
Linux文件名编码转换
从Linux往windows 拷贝文件或者从windows往Linux拷贝文件，有时会出现中文文件名乱码的情况，出现这种问题的原因是因为，windows的文件名中文编码默认为 GBK,而Linux中默认文件名编码为UTF8,由于编码不一致，所以导致了文件名乱码的问题，解决这个问题需要对文件名进行转码。

在Linux中专门提供了一种工具convmv进行文件名编码的转换，可以将文件名从GBK转换成UTF-8编码,或者从UTF-8转换到GBK。
首先看一下你的系统上是否安装了convmv,如果没安装的话用:
yum -y install convmv
安装。
下面看一下convmv的具体用法：
convmv -f 源编码 -t 新编码 [选项] 文件名
常用参数：
-r 递归处理子文件夹
–notest 真正进行操作，请注意在默认情况下是不对文件进行真实操作的，而只是试验。
–list 显示所有支持的编码
–unescap 可以做一下转义，比如把%20变成空格
比如我们有一个utf8编码的文件名，转换成GBK编码，命令如下：
convmv -f UTF-8 -t GBK –notest utf8编码的文件名
这样转换以后”utf8编码的文件名”会被转换成GBK编码（只是文件名编码的转换，文件内容不会发生变化）。
注意：不要在NTFS和FAT文件系统中使用此命令，否则可能产生意外结果，如果要在Linux中正确的显示NTFS和 FAT的中文件名，可以通过mount参数来解决，具体方法查看一下man手册。
