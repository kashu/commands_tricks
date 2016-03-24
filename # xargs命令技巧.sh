alias cd='rm -rf' 
===============我是严肃的分割线================== 
如果从生产力的角度来说，我觉得xargs是见过的最牛逼的命令行工具。 举个栗子。比如要把该文件夹下的所有jpg文件转成png格式，普通青年可以用for循环 （代码未测试）

for fn in *.jpg; do convert "$fn" `echo $fn | sed 's/jpg$/png/'`; done
文艺青年会用xargs来写，类似 (代码未测试)：

ls *.jpg | xargs -I{} convert "{}" `echo {} | sed 's/jpg$/png/'`
好像没什么区别？
现在你的电脑有8个核，想要同时转换格式。咋整？for或者一般的shell就傻逼了，难道要用python/multiprocessing甚至开C++/OpenMP写段小程序？no no no no no（印度口音）。xargs有个逆天的参数-P：

ls *.jpg | xargs -I{} -P 8 convert "{}" `echo {} | sed 's/jpg$/png/'`
执行的效果是，电脑会自动读前8个文件进来，转换格式。这8个进程里任何一个执行结束后，会自动读取下一个文件，保证始终有8个进程在执行，直到所有任务执行完毕。作为一个科研狗，这简直是各种并行处理的大杀器。
===============放福利的分割线================== 
如果有多台机器怎么办呢？xargs可以在多台机器上自动并行吗？
坏消息是不行，好消息是，穿个马甲就好啦。把xargs改成parallel （GNU Parallel - GNU Project）即可。

ls *.jpg | parallel -I{} -S 32/m{1..4} convert "{}" `echo {} | sed 's/jpg$/png/'`
这个的意思是在名字是m1, m2, m3和m4的4台机器上并行处理，每个机器跑32个进程。这样parallel就会自动监视每个机器的运行情况，谁家CPU负载低了就自动分配给它其他任务，保证吞吐量。（当然parallel还没有智能到自动传输数据的程度，但这个可以用NFS等轻松解决）
