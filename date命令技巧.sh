date

-d, --date=STRING
	display time described by STRING, not 'now'
-s, --set=STRING
	set time described by STRING
-R, --rfc-2822
	output date and time in RFC 2822 format.  Example: Mon, 07 Aug 2006 12:34:56 -0600


#用date手工设置系统时间
date -s //设置当前时间，只有root权限才能设置，其他只能查看。
#设置年、月、日 
date -s 20140410

#设置时、分、秒
date -s 12:30:50

date -s "12:30:50 20140410"  //一步到位设置年、月、日、时、分、秒
date -s 20080523 //设置成20080523，这样会把具体时间设置成空00:00:00
date -s 01:01:01 //设置具体时间，不会对日期做更改
date -s “01:01:01 2008-05-23″ //这样可以设置全部时间
date -s “01:01:01 20080523″ //这样可以设置全部时间
date -s “2008-05-23 01:01:01″ //这样可以设置全部时间
date -s “20080523 01:01:01″ //这样可以设置全部时间


另：使用ntpdate命令同步时间：http://www.kashu.org/193.html
hwclock -w把系统时间写入到硬件时钟里


# %z, +hhmm numeric time zone (e.g., -0400)
$ date +%z
+0800

# Convert seconds since the epoch (1970-01-01 UTC) to a date
date --date='@2147483647'

# Show the time on the west coast of the US (use tzselect(1) to find TZ)
TZ='America/Los_Angeles' date

# Show the local time for 9AM next Friday on the west coast of the US
date --date='TZ="America/Los_Angeles" 09:00 next Fri'

#昨天的时间
date +%Y%m%d_%H:%M:%S --date="-1 day"

#加减
date +%Y%m%d         //显示现在天年月日
date +%Y%m%d --date="+1 day"  //显示后一天的日期
date +%Y%m%d --date="-1 day"  //显示前一天的日期
date +%Y%m%d --date="-1 month"  //显示上一月的日期
date +%Y%m%d --date="+1 month"  //显示下一月的日期
date +%Y%m%d --date="-1 year"  //显示前一年的日期
date +%Y%m%d --date="+1 year"  //显示下一年的日期

date -d -{N}day '+%Y%m%d_%H:%M:%S'  //显示N天前的时间
date -d -3day '+%Y%m%d_%H:%M:%S'  //显示3天前的时间


