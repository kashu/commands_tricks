sort （info sort 可查看sort完整的说明手册）
-k, --key=KEYDEF
	sort via a key; KEYDEF gives location and type
-t, --field-separator=SEP
	use SEP instead of non-blank to blank transition
 By default, fields are separated by the empty string between a non-blank character and a blank character. By default a blank is a space or a tab.
-M, --month-sort
	compare (unknown) < 'JAN' < ... < 'DEC'
-h, --human-numeric-sort
	compare human readable numbers (e.g., 2K 1G)
-n, --numeric-sort
	compare according to string numerical value
-V, --version-sort
	natural sort of (version) numbers within text
-S, --buffer-size=SIZE
	use SIZE for main memory buffer
SIZE may be followed by the following multiplicative suffixes: % 1% of memory, b 1, K 1024 (default), and so on for M,G,T,P,E,Z,Y.This option can improve the performance of `sort' by causing it to start with a larger or smaller sort buffer than the default.However, this option affects only the initial buffer size. The buffer grows beyond SIZE if `sort' encounters input lines larger than SIZE.
--parallel=N
	change the number of sorts run concurrently to N
Set the number of sorts run in parallel to N. By default, N is set to the number of available processors, but limited to 8, as there are diminishing performance gains after that.  Note also that using N threads increases the memory usage by a factor of log N. Also see *note nproc invocation::.
-r, --reverse
	reverse the result of comparisons
-u, --unique
	with -c, check for strict ordering; without -c, output only the first of an equal run
-m, --merge
	merge already sorted files; do not sort
-o, --output=FILE
	write result to FILE instead of standard output
Normally, `sort' reads all input before opening OUTPUT-FILE, so you can safely sort a file in place by using commands like `sort -o F F' and `cat F | sort -o F'.



#根据每行字符的长度从长到短进行排序
awk '{print length, $0}' /etc/passwd | sort -n | cut -f2- -d' '

sort --parallel=4 -S 10M


