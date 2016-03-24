nohup - run a command immune to hangups, with output to a non-tty
把任务抛到后台执行，当你注销或脱机时任务也能够继续执行，任务执行时的输出信息会放在~/nohup.out文件中

nohup ./file.sh &

感觉下面和上面没什么区别……
./file.sh &

或者使用之前学过的，使用at服务来实现
