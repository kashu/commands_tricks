文件名编码转换:
从Linux往 windows拷贝文件或者从windows往Linux拷贝文件，有时会出现中文文件名乱码的情况，出现这种问题的原因是因为，windows的文件名中文编码默认为GBK,而Linux中默认文件名编码为UTF8,由于编码不一致，所以导致了文件名乱码的问题，解决这个问题需要对文件名进行转码。
在Linux中专门提供了一种工具convmv进行文件名编码的转换，可以将文件名从GBK转换成UTF-8编码，或者从UTF-8转换到GBK。

$ sudo apt-get install convmv -y

下面看一下convmv的具体用法：
convmv -f 源编码 -t 新编码 [选项] 文件名

#常用参数：
-r 递归处理子文件夹
--notest 真正进行操作，请注意在默认情况下是不对文件进行真实操作的，而只是试验。
--list 显示所有支持的编码
--unescap 可以做一下转义，比如把%20变成空格
比如我们有一个utf8编码的文件名，转换成GBK编码，命令如下：


convmv -f gbk -t utf8 -r utf8编码的文件名(或用*表示全部)
convmv -f gbk -t utf8 --notest -r utf8编码的文件名(或用*表示全部)
