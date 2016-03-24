详见更好的：enca命令技巧

$ iconv -f 原本编码 -t 新编码 filename [-o newfile]
选项与参数：
--list ：列出 iconv 支持的语系数据
-f     ：from ，亦即来源之意，后接原本的编码格式；
-t     ：to ，亦即后来的新编码要是什么格式；
-o file：如果要保留原本的档案，那么使用 -o 新档名，可以建立新编码档案。


把大五码编码文件转换成utf8编码的文件：
$ iconv -f big5 -t utf8 get_virus_def.sh -o get.big.sh

把大五码繁体中文文件转换成简体中文文件：
$ iconv -f big5 -t utf8 get_virus_def.sh | iconv -f utf8 -t big5 | iconv -f big5 -t gb2312 | iconv -f gb2312 -t utf8 -o get.gb2312.sh

去http://linux.vbird.org下载任意的网页文件进行练习，这网站的编码就是big5
