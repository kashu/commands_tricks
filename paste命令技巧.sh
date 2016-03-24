#用于练习的文件1和2
$ cat 1
a
b
c

$ cat 2
0
1
2
3


#示例1
$ paste 1 2
a	0
b	1
c	2
	3


#示例2
$ paste -s 1 2
a	b	c
0	1	2	3


#示例3
$ paste -sd' ' 1 2
a b c
0 1 2 3


#示例4
$ paste -sd'\n' 1 2
a
b
c
0
1
2
3

