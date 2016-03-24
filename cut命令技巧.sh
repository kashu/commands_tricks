#/bin/sh
cut
-d,	use DELIM instead of TAB for field delimiter
-f,	select only these fields;  also print any line that contains no delimiter character, unless the -s option is specified
-s,	do not print lines not containing delimiters
--output-delimiter=STRING
	use STRING as the output delimiter the default is to use the input delimiter
--complement
	complement the set of selected bytes, characters or fields


#用于练习的内容模板
$ echo -e https://kashu.org\\n{1..3}\\ttab'\'
https://kashu.org
1	tab\ https://kashu.org
2	tab\ https://kashu.org
3	tab\

#示例1：cut默认使用TAB作为delimiter（分隔符）（cat -A可以看到特殊字符，空格、tab符、换行符等）
$ echo -e https://kashu.org\\n{1..3}\\ttab'\' | cat -A
https://kashu.org$
1^Itab\ https://kashu.org$
2^Itab\ https://kashu.org$
3^Itab\$

$ echo -e https://kashu.org\\n{1..3}\\ttab'\' | cut -f1
https://kashu.org
1
2
3


#示例2：-d后面只能跟一个字符，当有特殊字符时一定要单引号括起来
#not good
$ echo -e https://kashu.org\\n{1..3}\\ttab'\' | cut -d\ -f2
cut: the delimiter must be a single character
Try 'cut --help' for more information.

#Good
$ echo -e https://kashu.org\\n{1..3}\\ttab'\' | cut -d'\' -f2
https://kashu.org
 https://kashu.org
 https://kashu.org


#示例3：以空格为delimiter并且只过滤出第2 filed（-s不显示不包含delimiter的行）
#Not Good
$ echo -e https://kashu.org\\n{1..3}\\ttab'\' | cut -d' ' -f2
https://kashu.org
https://kashu.org
https://kashu.org
3	tab\

#Good
$ echo -e https://kashu.org\\n{1..3}\\ttab'\' | cut -d' ' -f2 -s
https://kashu.org
https://kashu.org


用于练习的内容模板：
$ cat a
a	1	https
b	2	kashu
c	3	org

#示例4：--output-delimiter能把输出的delimiter替换成任意的字符
$ cut -f1-3 --output-delimiter='!@!' a
#注：上面的cut没有使用-d选项，说明这里的文件a中的delimiter是TAB符号
a!@!1!@!https
b!@!2!@!kashu
c!@!3!@!org


#示例5：--complement显示匹配出来的相反部分（complement the set of selected bytes, characters or fields）
$ cut -f1 a
a
b
c

$ cut -f1 --complement a
1	https
2	kashu
3	org

$ cut -f2,3 --complement a
a
b
c


#范围的表示方法：
N	只有第N项
N-	从第N项一直到行尾
N-M	从第N项到第M项(包括M)
-M	从一行的开始到第M项(包括M)
-	从一行的开始到结束的所有项

