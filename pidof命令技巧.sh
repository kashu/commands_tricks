查看某个进程的ID
$ pidof remmina
31682

$ pidof nginx
1153 1152 1151 1150 1149

#-s, 只显示一个结果
$ pidof -s nginx
1153

#tr ' ' '\n'|sort -n是为了给多个PID的情况下进行一个从小到大的排序，echo $i可灵活替换成其它的命令
$ for i in `pidof nginx|tr ' ' '\n'|sort -n`;do echo $i;done
1149
1150
1151
1152
1153


#方便在shell脚本中判断某个进程是否正在运行
#判断某个服务是否正在运行
if [ -n "`/sbin/pidof -s radiusd`" ]; then
                echo "radiusd: already running"
                return 1
fi

/usr/eflow/bin/radiusd -d /usr/eflow/raddb -a /usr/eflow/radacct
sleep 1

#判断是否在运行
if [ -z "`/sbin/pidof -s radiusd`" ]; then
                echo "radiusd: startup failed"
                return 0
else
                echo "radiusd: startup success"
                return 1
fi
