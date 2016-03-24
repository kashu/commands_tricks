locate命令结合正则表达式去搜索，功能很强大！
--regex Interpret all PATTERNs as extended regexps.（支持正式表达式的表示方法）
-i  忽略字符的大小写
-c  显示匹配到的条目数量，而不是把它们作为标准输出打印出来
-n  N  只把匹配到的N个结果显示出来

#把/etc目录里所有.conf或.cfg或.config结尾的文件全部搜索出来了，并按文件大小从大到小的以human readable的长模式列出来:
$ locate --regex ^'\/etc\/.*\.(conf|cfg|config)$' | xargs ls -lSh | more

#把所有路径中只要含有号码7777777的都列出来：
$ locate --regex '.*7777777.*' | more

#把所有路径中含有administrator的都列出来，不管这个单词的大小写是怎么样的：
$ locate --regex -i '.*administrator.*' | more

#把所有.png和.jpg的图片文件路径都列出来：
$ locate --regex -i '.*\.(png|jpg)$' | more

#显示匹配到的所有.png和.jpg的图片文件的数量：
$ locate --regex -i -c '.*\.(png|jpg)$'
33152

#只把匹配到的前10个结果显示出来：
$ locate --regex -i -n 10 '.*administrator.*' | more
