#示例1
$ who | tr -s ' ' '\t'
kashu	:0	2015-05-09	18:34	(:0)
kashu	pts/0	2015-05-09	18:35	(:0)
kashu	pts/13	2015-05-09	18:37	(:0)
kashu	pts/15	2015-05-09	20:05	(:0)

$ who | tr -s '[:blank:]' '-'
kashu-:0-2015-05-09-18:34-(:0)
kashu-pts/0-2015-05-09-18:35-(:0)
kashu-pts/13-2015-05-09-18:37-(:0)
kashu-pts/15-2015-05-09-20:05-(:0)


#示例2
$ who | tr -d '[:digit:]'
kashu    :           -- : (:)
kashu    pts/        -- : (:)
kashu    pts/       -- : (:)
kashu    pts/       -- : (:)


#示例3
$ who | tr '[a-z]' '[A-Z]'
KASHU    :0           2015-05-09 18:34 (:0)
KASHU    PTS/0        2015-05-09 18:35 (:0)
KASHU    PTS/13       2015-05-09 18:37 (:0)
KASHU    PTS/15       2015-05-09 20:05 (:0)

$ who | tr '[:lower:]' '[:upper:]'
KASHU    :0           2015-05-09 18:34 (:0)
KASHU    PTS/0        2015-05-09 18:35 (:0)
KASHU    PTS/13       2015-05-09 18:37 (:0)
KASHU    PTS/15       2015-05-09 20:05 (:0)

$ who | tr '[:blank:]' '-'
kashu----:0-----------2015-05-09-18:34-(:0)
kashu----pts/0--------2015-05-09-18:35-(:0)
kashu----pts/13-------2015-05-09-18:37-(:0)
kashu----pts/15-------2015-05-09-20:05-(:0)

#大写变小写，小写变大写
$ ifconfig | head -n 1 | tr '[a-zA-Z]' '[A-Za-z]'
ETH0      lINK ENCAP:eTHERNET  hwADDR 00:0C:29:E6:81:E1  

#示例4
#Not good
$ who | tr -d -s
tr: missing operand
Try 'tr --help' for more information.

#Not good
$ who | tr -d '-s'
tr: missing operand
Try 'tr --help' for more information.

#Good
$ who | tr -d s-
kahu    :0           20150509 18:34 (:0)
kahu    pt/0        20150509 18:35 (:0)
kahu    pt/13       20150509 18:37 (:0)
kahu    pt/15       20150509 20:05 (:0)

#Good
$ who | tr -d -- '-s'
kahu    :0           20150509 18:34 (:0)
kahu    pt/0        20150509 18:35 (:0)
kahu    pt/13       20150509 18:37 (:0)
kahu    pt/15       20150509 20:05 (:0)


#把dos文件格式转换成linux文件格式
$ file /etc/passwd Backup-codes.txt 
/etc/passwd:  ASCII text
Backup-codes: ASCII English text, with CRLF line terminators（这是DOS下的文本格式）

$ tr -d '\r' < Backup-codes.txt > a.txt
\r是DOS下面的断行字符，把这个字符删除，实现了DOS文件格式转换到linux文件格式

$ file a.txt
a.txt: ASCII English text


#文本加密、解密
tr '"a-m""n-z""A-M""N-Z""0-4""5-9"' '"N-Z""A-M""n-z""a-m""5-9""0-4"'
tr '"N-Z""A-M""n-z""a-m""5-9""0-4"' '"a-m""n-z""A-M""N-Z""0-4""5-9"'

#加密
$ echo '520 https://kashu.org' | tr '"a-m""n-z""A-M""N-Z""0-4""5-9"' '"N-Z""A-M""n-z""a-m""5-9""0-4"'
075 UGGCF://XNFUH.BET
#解密
$ echo '075 UGGCF://XNFUH.BET' | tr '"a-m""n-z""A-M""N-Z""0-4""5-9"' '"N-Z""A-M""n-z""a-m""5-9""0-4"'
520 https://kashu.org
#加密并解密
$ echo '520 https://kashu.org' | tr '"a-m""n-z""A-M""N-Z""0-4""5-9"' '"N-Z""A-M""n-z""a-m""5-9""0-4"' | tr '"N-Z""A-M""n-z""a-m""5-9""0-4"' '"a-m""n-z""A-M""N-Z""0-4""5-9"'
520 https://kashu.org

