删除开头和结尾的空格或tab
测试文件如下：
[root@kashu tmp]# cat -A file.txt
^Ikashu $
  love   $
Linux^I$

使用sed去除开头和结尾的空格或tab
[root@kashu tmp]# sed -e 's/^[ \t]*//' -e 's/[ \t]*$//' file.txt |cat -A
kashu$
love$
Linux$

对文件进行修改操作
[root@kashu tmp]# sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' file.txt

使用awk去除开头和结尾的空格或tab
[root@kashu tmp]# awk '{$1=$1}{print}' file.txt |cat -A
kashu$
love$
Linux$
