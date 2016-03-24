tail /tmp/file.txt

tail -n5 /tmp/file.txt

tail -n30 -f /tmp/file.txt

用tail就不需要用tailf了







tailf

DESCRIPTION
	tailf  will  print out the last 10 lines of a file and then wait for the file to grow.  It is similar to tail -f but does not access the file when it is not growing.  This has the side effect of not updating the access time for the file, so a filesystem flush does not occur periodically when no log activity is happening.

	tailf is extremely useful for monitoring log files on a laptop when logging is infrequent and the user desires that the hard disk spin down to conserve battery life.


-n, --lines=N, -N
	output the last N lines, instead of the last 10.


$ tailf /tmp/aa
$ tailf -n 30 /tmp/aa




