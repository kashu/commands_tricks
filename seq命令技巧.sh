print a sequence of numbers. Print numbers from FIRST to LAST, in steps of INCREMENT.

#默认数字从小到大以1为步长递增，
$ seq 0 3
0
1
2
3

#数字顺序从大小到
$ seq 3 -1 1
3
2
1

#以5为递增步长
$ seq 0 5 10
0
5
10

#等宽，以0开头补齐数字位数宽度：
$ seq -w 0 5 10
00
05
10

#-s，分隔符
$ seq -s' ' -w 10
01 02 03 04 05 06 07 08 09 10

$ seq -s'___' -w 10
01___02___03___04___05___06___07___08___09___10

#获取奇数
$ seq 1 2 8
1
3
5
7

#获取偶数
$ seq 2 2 6
2
4
6

