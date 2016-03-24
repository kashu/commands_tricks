expr
#用途
求表达式变量的值。

#语法
expr Expression

#描述
expr 命令读入 Expression 参数，计算它的值，然后将结果写入到标准输出。

您必须对 Expression 参数应用以下规则：
	用空格隔开每个项。
	用 \ （反斜杠） 放在 shell 特定的字符前面。
	对包含空格和其他特殊字符的字符串要用引号括起来。

整数前面可以放一个一元连字符。在内部，整数被当作 32 位，双互补数。
注： expr 命令返回一个 0 来指示一个零值，而不是空字符串。

以下项描述了 Expression 参数的运算符和关键字。需要转义的字符由一个 \ （反斜杠） 放在前面。这些项按照优先权递增的顺序列出，具有相等的优先权的运算符分组在 {} （大括号） 中：

Expression1 \| Expression2	返回 Expression1 如果它不是空值或者 0 值的话，否则返回 Expression2 。
Expression1 \& Expression2	返回 Expression1 如果两个表达式都不是空值或者 0 值，否则返回一个 0 值。
Expression1 { =, \>, \>=, \<, \<=, != } Expression2	如果两个表达式都是整数，返回整数比较的结果；否则它返回的是字符串比较的结果。
Expression1 {+, - } Expression2	整数值变量的加或者减。
Expression1 { \*, \, % } Expression2	整数值变量的乘、除或者提供除法的余数。
Expression1 : Expression2	将 Expression1 的运算得到的字符串与 Expression2 的运算结果的正则表达式模式进行比较。正则表达式语法与 ed 命令相同，除了所有的模式固定到字符串的开始之外（也就是说，只有以字符串的第一个字符开始的序列才被正则表达式匹配）。因此 ^ （插入符号） 在这种情况下就不是特殊字符。
一般地，匹配运算符返回匹配的字符个数（失败的时候返回 0）。如果模式包含了一个子表达式，也就是：
\( Expression \)
则会返回包含了实际匹配的字符的字符串。

整理顺序可以定义在字符范围内使用的等价类。有关整理顺序和等价类的更多信息，请参阅《AIX V6.1 本地语言支持指南与参考大全》 中的『了解语言环境的环境变量』 。

注： 以下字符串变量会超过标准，其行为可能在不同的操作系统中会有不同。这些字符串变量是“不”可移植的。

match String1 String2
与 Expression1 : Expression2 相同。

length String1
返回 String1 的长度。

index String1 String2
返回 String1 中包含 String2 中任意字符的第一个位置。

substr String1 StartPosition Length
返回一个以 StartPosition 的字符开始的在 String1 中的字符串，并且是 Length 长度的字符串。

退出状态

此命令返回以下退出值：
0	Expression 参数运算值既不为空也不为 0。
1	Expression 参数的计算值或者为空或者为 0。
2	Expression 参数无效。
>2	发生错误。
注： 在 shell 处理完参数后，expr 命令除了利用数值外不能区分运算符和操作数。因此，如果 $a 的值是 j 的话，命令：
expr $a = j
就像：
expr j = j
在 shell 将所有的参数都传给 expr 命令之后。以下情况也为 true：
expr X$a = Xj

#示例
#要修改一个 shell 变量，请输入：
COUNT=`expr $COUNT + 1`
这会加 1 到 shell 变量 $COUNT 上。 expr 命令以 grave accent 包装，这会导致 shell 将 expr 命令的标准输出替换到 COUNT= 命令的标准输出。$COUNT 变量使用前必须初始化。


#要想得到 $STR shell 变量的长度，请输入：
expr $STR : ".*"
.*（点，星号）模式会对任何字符串从头到尾去匹配，因此冒号运算符给出 $STR 变量的长度作为匹配字符的数目。注，.* 必须在引号内，来防止 shell 将 *（星号）处理成模式匹配字符。引号不是模式中的一部分。

如果 $STR 变量设置成空字符串或者包含了任何空格（空白或者制表键）的话，那么该命令会显示错误消息 expr: syntax error 。这是因为 shell 通常不会将空字符串传递给命令。在这种情况下，expr 命令只能看见：
 :.*
shell 还会除去单个的引号。不起作用的原因是因为冒号运算符要求有两个值。此问题可以通过将 shell 变量以双引号括起来解决：
LENGTH=`expr "$STR" : ".*"`
现在，如果 $STR 变量的值为空的话，LENGTH 变量被设置成 0 值。
示例：expr "$SHELL" : ".*"
9

示例：expr $SHEL : ".*"
expr: syntax error

示例：expr "$SHEL" : ".*"
0
***推荐将 shell 变量用双引号括起来。不要用单引号标记括起来。
echo $SHELL
/bin/bash

示例：expr "$SHELL" : ".*"
9

示例：expr length "$SHELL"
9

示例：expr length $SHEL
expr: syntax error

示例：expr length "$SHEL"
0

示例：expr length "$SHEL"^C
echo $SHELL | wc -L
9


#要想使用一个字符串的一部分，请输入：
FLAG=`expr "$FLAG" : "-*\(.*\)"`
只要 $FLAG shell 变量前面有连字符，就会除去连字符。冒号运算符给出 FLAG 变量的一部分，该变量由在 \( 和 \) 字符（反斜杠，开括号和反斜杠，闭括号）中间的子表达式匹配。如果您忽略 \( 和 \) 子表达式字符的话，冒号运算符会给出匹配的字符数目。

如果 $FLAG 变量设置成 -（连字符），那么该命令会显示一个语法错误消息。这是因为 shell 会将 $FLAG 变量的值替换，在运行 expr 命令之前。expr 命令不知道连字符是一个变量的值。它只能理解：

 - : -*\(.*\)
并且它会将第一个连字符解释成减号运算符。要消除这种问题，请使用：
FLAG=`expr "x$FLAG" : "x-*/(.*/)"`


#要想使用 expr 命令在 if 语句中，请输入：
if expr "$ANSWER" : "[yY]" &> /dev/null
那么返回 ANSWER 以 "y" 或 "Y" 开始fi
如果 $ANSWER 变量以 y 或 Y 开始的话，if 语句的 then 部分会执行。如果匹配成功表达式的结果为 1，并且 expr 命令会返回一个为 0 的退出值，此退出值被 if 语句识别成逻辑值 True。如果匹配失败，结果为 0，出口值为 1。
示例： if expr "Y" : "[yY]" &> /dev/null; then echo True; fi
示例： if expr "X" : "[yY]" &> /dev/null; then echo None; fi
将 expr 命令的标准输出重新定向到 /dev/null 特殊文件，而不显示该表达式的结果。如果没有对它重新定向，结果就会写到标准输出中，通常是显示在屏幕上。


#考虑以下表达式：
expr "$STR" = "="
如果 $STR 变量有值为 = （等号），那么在 shell 处理完此命令之后，expr 命令会看到表达式：
= = =
expr 命令将此解释成在一行中的三个等号运算符，并显示一个语法出错消息。一旦 shell 变量的值与 expr 运算符中的一个相同，这种情况就会发生。避免这种问题的方法是，将该表达式写成：
expr "x$STR" = "x="

expr可以返回其本身的退出状态，不幸的是返回值与系统最后退出命令刚好相反，成功返回1，任何其他值为无效或错误。下面的例子测试两个字符串是否相等，这里字符串为
"hello"和"hello"。
value=hello
expr $value = "hello"
1
echo $?
0
expr返回1。不要混淆了，这表明成功。现在检验其最后退出状态，返回0表示测试成功，
“hello”确实等于“hello”。


#要想返回 $SHELL 环境变量 /bin/bash 的长度，请输入：
示例：expr length $SHELL
显示以下内容：
9


#要想返回 "fd" 字符串中的任何一个字符在 "abcdef" 中出现的第一个位置，请输入：
示例：expr index abcdef fd
显示以下内容：
4

示例：expr index abcdef df
显示以下内容：
4

#要想返回 "ac" 字符串的任何一个字符在 "abcdef" 中出现的第一个位置，请输入：
示例：expr index abcdef ac
显示以下内容：
1

示例：expr index abcdef ca
显示以下内容：
1


#要想返回 "Goodnight Ladies" 字符串中从位置 11 开始的 6 个字符长的字符串，请输入：
示例：expr substr "Goodnight Ladies" 11 6
显示以下内容：
Ladies







expr命令一般用于整数值，但也可用于字符串。一般格式为：
expr argument operator argument
expr也是一个手工命令行计数器。
$expr 10 + 10
20
$expr 1500 + 900
2500
$expr 30 / 3
10
$expr 30 / 3 / 2
5
(注意运算符左右都有空格 ，如果没有空格表示是字符串连接)
使用乘号时，必须用反斜线屏蔽其特定含义。因为shell可能会误解显示星号的意义。
$expr 30 * 3
90

#数值测试
可以用expr测试一个数。如果试图计算非整数，将返回错误。
$rr=1.1
$expr $rr + 1
expr: non-numeric argument
$rr=2
$expr $rr + 1
3
(注意：这个例子与原文不同)
这里需要将一个值赋予变量（不管其内容如何），进行数值运算，并将输出导入dev/null，然后测试最后命令状态，如果为0，证明这是一个数，其他则表明为非数值。
$value=12
$expr $value + 10 > /dev/null 2>&1
$echo $?
0
这是一个数。
$value=hello
$expr $value + 10 > /dev/null 2>&1
$echo $?
2
这是一个非数值字符。



 模式匹配
expr也有模式匹配功能。可以使用expr通过指定冒号选项计算字符串中字符数。.*意即任
何字符重复0次或多次。
$value=accounts.doc
$expr $value : '.*'
12

在expr中可以使用字符串匹配操作，这里使用模式. d o c抽取文件附属名。
$expr $value : '(.*).doc'
accounts

shell 中数组

用
$varname[0]=value1
$varname[1]=value2
....
来定义
用
$echo ${varname[0]}
方式来引用


#显示字串的长度
expr length cisco
5

#从位置处抓取字串(从第3个字串开始，往后面截取共5位长度的字串)
expr substr "this is a test" 3 5
is is

#索引字串数（从起始位置到出现的第一个字符e，一共有2位）
expr index "testforthegame" e
2

字串真实重现
expr quote thisisatestformela
thisisatestformela


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

在Linux shell命令中expr虽然不是很起眼，但是它的作用是非常大的！到目前为止，我个人看来最大的作用就是两个——四则运算和字符串的操作。

先说四则运算，在Shell中四则运算不能简简单单的加减乘除，应该要写如下的格式：

$val1=`$val2 - 1`

其中“=”后面用“`”包住表达式，这个符号在Shell中十分有用，是Tab键上面“~”的原来形式。可以用来将很多命令的结果保存到一个变量中去。接着就是运算符了，运算符的左右两边必须是空格，否则会出错。


接着是强大的字符串操作：
提取指定字符的下标：expr index 内容 字符，例如：$ind=`expr index "$content" "="`
提取字符串的子串：expr substr 内容 起始位置 终点位置，例如：$con=`expr substr "$content" "1" $ind`
