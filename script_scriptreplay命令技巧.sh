script
$ script -t 2>> test.t -a test.a -q

#Usage:
 script [options] [file]

#Options:
 -t, --timing[=<file>]   output timing data to stderr (or to FILE)
 -a, --append            append the output
 -q, --quiet             be quiet



scriptreplay

For CentOS/RHEL
$ scriptreplay test.t test.a

For Ubuntu
$ scriptreplay -t test.t test.a
$ scriptreplay -t test.t test.a -d 1.4
$ scriptreplay -t test.t test.a -d 2

#Usage:
 scriptreplay [-t] timingfile [typescript] [divisor]

#Options:
 -t, --timing <file>     script timing output file
 -s, --typescript <file> script terminal session output file
 -d, --divisor <num>     speed up or slow down execution with time divisor
