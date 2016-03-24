逻辑备份:
  mysqldump(数据导出工具)
  mysqldump options db_name[table_name]  //备份单个数据库
  mysqldump 选项 --database database-name1 [databases-name2]....  //备份指定的数据库一个或者多个
  mysqldump 选项 --all-database  //备份所有的数据库
  链接选项:
  -u :指定用户名
   -p:指定密码
   -h:指定服务器ip或者域名
   -P(大写):指定端口
eg:/usr/bin/mysqldump -u root -h 202.194.132.237 -P 3306 -p BBS user>/home/wuxiaoxiao/user.txt
输出内容选项:
--add-drop-database:每个数据库创建语句之前加上drop database语句
--add-drop-table:每个表创建语句之前加上drop table语句
-n:不包含数据库的创建语句
-t:不包含数据表的创建语句
-d:不包含数据
输出格式选项:
 --compact:使输出结果简洁
 -c --compact-insert:使输出文件中的insert语句包含字段名
 -T:将数据库表中的数据备份为单纯的数据文本和建表sql俩个文件
   --fields-terminated-by=name(域分割符)
   --fields-enclosed-by=name(域引用符)
   --fields-optionally-enclosed-by=name(域可选引用符)
   --fields-escaped-by=name(转移字符)
eg:/usr/bin/mysqldump -u root -h 202.194.132.237 -P 3306 -p BBS user -T ./bak
字符集选项:
--default-character-set=name:设置导出的客户端字符集
eg:mysql -u root -p --compact --default-character-set=utf8 BBS user > test.txt
其他选项:
-F:备份前刷新日志
-l:给所有表加读锁(备份期间使用,使备份的数据保持一致性)

备份:
备份所有数据库
mysqldump -u root -p  --all-database  >  all-database.sql
备份数据库test
mysqldump -u root -p  test  >  test.sql
 备份数据库test下的temp表
mysqldump -u root -p  test demp >  test.sql
备份数据库下的所有表为逗号分割的文本,备份到/temp
mysqldump -u root -p test -T /temp --fields-terminated-by ',' 



完全恢复:

msyql -u root -p < bakfile
注意:将备份恢复后数据并不完整,还需要将备份后执行的日志进行重做
mysqlbinlog binlog-file | mysql -u root -p***
举个完整的mysqldump备份和恢复的例子:
上午9点备份数据库
mysqldump -u root -p -l -F test > test.dmp
9点半备份完毕,然后想数据库中插入数据
10点数据库突然故障,数据无法访问,需要恢复备份
mysql -u root -p test < test.dmp
恢复后的数据并不完整,9点半插入的数据并没有恢复
使用mysqlbinlog恢复自mysqldump备份以来的binlog
mysqlbinlog binlogfilename | mysql -u root -p test
基于时间点恢复:
如果上午10点发生了误操作.可以用下面语句进行备份和binlog将数据库恢复到故障前:
mysqlbinlog --stop-date="2005-04-20 9:59:59" binlogfile | mysql -u root -p test
跳过故障的时间点,继续执行后面的binlog,完成恢复
mysqlbinlog --start-date="2005-04-20 9:59:59" binlogfile | mysql -u root -p test
基于位置恢复:
mysqlbinlog --start-date="2005-04-20 9:55:59" --stop-date="2005-04-20 10:05:00" binlogfile > test.sql
查看此文件,找出出错语句前后的位置号,例如是368312,368315
mysqlbinlog --stop-position="368312" binlogfile | mysql -u root -p test
mysqlbinlog --start-position="368315" binlogfile | mysql -u root -p test

表的导入和导出
导出:
    mysqldump -u username -p -T target_dir dbname tablename [options]
options:
   --fields-terminated-by=name(域分割符)
   --fields-enclosed-by=name(域引用符)
   --fields-optionally-enclosed-by=name(域可选引用符)
   --fields-escaped-by=name(转移字符)
备份数据库下的所有表为逗号分割的文本,备份到/temp
mysqldump -u root -p -T /temp test --fields-terminated-by ',' --fields-optionally-enclosed-by '"'
导入:
   msyqlimport -u root -p [LOCAL] dbname order_tab.txt [options]
OPTIONS:
   --fields-terminated-by=name(域分割符)
   --fields-enclosed-by=name(域引用符)
   --fields-optionally-enclosed-by=name(域可选引用符)
   --fields-escaped-by=name(转移字符)
eg:mysqlimport -u root -p test order.txt --fields-terminated-by=',' --fields-enclosed-by='"'
