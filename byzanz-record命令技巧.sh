sudo apt-get install byzanz


全屏录制10秒钟后结束
byzanz-record -d 10 test.gif

录制指定要执行的命令，直接命令退出才结束录制
byzanz-record -e "ping c.cn -c 5" test1.gif

开始录制前延时3秒钟后才开始录制
byzanz-record -d 10 --delay=3 test2.gif

录制一个区域为800x600的画面
byzanz-record -h 800 -w 600 -d 8 test3.gif


录制一个区域为800x600的画面，生成flv视频文件
byzanz-record -h 800 -w 600 -d 10 test4.flv



man byzanz-record