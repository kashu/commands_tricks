通过sort/uniq获取文件内容的交集、合集和不同之处：假设有a、b两个文本文件，文件本身已经去除了重复内容。下面是效率最高的方法，可以处理任何体积的文件，甚至几个G的文件。(Sort对内存没有要求，但也许你需要用 -T 参数。)可以试着比较一下，你可以看看如果用Java来处理磁盘上文件的合并，需要用多少行代码。
cat a b | sort | uniq > c   # c 是a和b的合集

cat a b | sort | uniq -d > c   # c 是a和b的交集

cat a b b | sort | uniq -u > c   # c 是a和b的不同

汇总一个文本内容里第三列数字的和(这个方法要比用Python来做快3倍并只需1/3的代码量)：
awk ‘{ x += $3 } END { print x }’ myfile

如果你想查看一个目录树里的文件的体积和修改日期，用下面的方法，相当于你挨个目录做”ls -l”，而且输出的形式比你用”ls -lR”更可读：
find . -type f -ls

使用xargs命令。这个命令非常的强大。注意每行上你可以控制多少个东西的执行。如果你不确定它是正确的执行，先使用xargs echo。同样，-I{} 也非常有用。例子：
find . -name \*.py | xargs grep some_function

cat hosts | xargs -I{} ssh root@{} hostname

假设你有一个文本文件，比如一个web服务器日志，在某些行上有一些值，比如URL中的acct_id参数。如果你想统计每个acct_id的所有请求记录：
cat access.log | egrep -o ‘acct_id=[0-9]+’ | cut -d= -f2 | sort | uniq -c | sort -rn
