示例文件：
$ cat -n a.sh 
     1	#!/bin/bash 
     2	shopt -s expand_aliases
     3	alias aa='ls /home'
     4	aa

NR变量，表示：行
显示第2行
$ awk 'NR==2 {print}' a.sh
shopt -s expand_aliases

显示第2行至第4行
$ awk 'NR==2,NR==4 {print}' a.sh
shopt -s expand_aliases
alias aa='ls /home'
aa

显示第2行和第4行
$ awk 'NR==2||NR==4 {print}' a.sh
shopt -s expand_aliases
aa

显示所有行
$ awk '{print}' a.sh
#!/bin/bash 
shopt -s expand_aliases
alias aa='ls /home'
aa

FS变量，表示：字段（字段默认以空格或tab分隔）
显示第2行的第1个字段
$ awk 'NR==2 {print $1}' a.sh 
shopt 

显示第2行的第2个字段
$ awk 'NR==2 {print $2}' a.sh 
-s 

显示第2行的第1个和第3个字段
$ awk 'NR==2 {print $1,$3}' a.sh 
shopt  expand_aliases 

显示第2行和第3行的第1个和第3个字段
$ awk 'NR==2||NR==3 {print $1,$3}' a.sh 
shopt  expand_aliases 
alias  /home' 

/pattern/，匹配有此内容的行（运行正则表达式），并予以处理
匹配有shopt关键字的行，并且显示其中的第3个字段
$ awk '/shopt/{print $3}' a.sh 
expand_aliases

匹配aliases结尾的行，并显示其中最后一个字段
$ awk '/aliases$/{print $NF}' a.sh 
expand_aliases

显示奇数行
$ cat -n a.sh | awk '(NR%2)==1{print}'
     1	#!/bin/bash 
     3	alias aa='ls /home'

显示偶数行
$ cat -n a.sh | awk '(NR%2)==0{print}'
     2	shopt -s expand_aliases
     4	aa

显示倒数第二列的内容：
awk '{ print $(NF-2) }'

使用awk去除开头和结尾的空格或tab
# awk '{$1=$1}{print}' file.txt |cat -A
kashu$
love$
Linux$

把所有的换行符替删除或替换成其它的符号：
所有换行符替换成空格
# cut -d'.' -f4 ip_scan.list | xargs echo
# echo `cut -d'.' -f4 ip_scan.list`
# awk '{printf" "$0}' file
# cut -d'.' -f4 ip_scan.list |tr -s '\n' ' '
所有换行符替换成|
# awk '{printf"|"$0}' file
# cut -d'.' -f4 ip_scan.list |tr -s '\n' '|'

把所有空格或tab删除，一行一个显示
cat /tmp/b | xargs echo | tr -s ' ' '\n'
cut -d'.' -f4 /tmp/b | xargs echo | tr -s ' ' '\n'



Target a specific column for pattern substitution

awk '{gsub("foo","bar",$5)}1' file
Awk replaces every instance of foo with bar in the 5th column only.
