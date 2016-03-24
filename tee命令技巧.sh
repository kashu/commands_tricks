tee
the default behavior is overwrite!!

-a, --append
	append to the given FILEs, do not overwrite


$ who | tee who.txt
kashu    :0           2015-05-17 00:14 (:0)
kashu    tty1         2015-05-16 15:12
kashu    pts/12       2015-05-17 00:14 (:0)

$ cat who.txt 
kashu    :0           2015-05-17 00:14 (:0)
kashu    tty1         2015-05-16 15:12
kashu    pts/12       2015-05-17 00:14 (:0)


$ id | tee who.txt 
uid=1000(kashu) gid=1000(kashu) groups=1000(kashu),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),108(lpadmin),124(sambashare),128(wireshark)

$ cat who.txt
uid=1000(kashu) gid=1000(kashu) groups=1000(kashu),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),108(lpadmin),124(sambashare),128(wireshark)

$ who | tee -a who.txt 
kashu    :0           2015-05-17 00:14 (:0)
kashu    tty1         2015-05-16 15:12
kashu    pts/12       2015-05-17 00:14 (:0)

$ cat who.txt 
uid=1000(kashu) gid=1000(kashu) groups=1000(kashu),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),108(lpadmin),124(sambashare),128(wireshark)
kashu    :0           2015-05-17 00:14 (:0)
kashu    tty1         2015-05-16 15:12
kashu    pts/12       2015-05-17 00:14 (:0)


同时生成3个文件，并向里面写入同样的内容：text
echo "text" | tee >(>1) >(>2) >(>3)



In computing, tee is a command in various command-line interpreters (shells) such as Unix shells, 4DOS/4NT and Windows PowerShell, which displays or pipes the output of a command and copies it into a file or a variable. It is primarily used in conjunction with pipes and filters. Source

Urfix uses tee for a myriad of things everything from backups to piping.

Enjoy!

1) Save a file you edited in vim without the needed permissions

:w !sudo tee %

I often forget to sudo before editing a file I don’t have write permissions on. When you come to save that file and get the infamous “E212: Can’t open file for writing”, just issue that vim command in order to save the file without the need to save it to a temp file and then copy it back again.

2) Use tee to process a pipe with two or more processes

echo "tee can split a pipe in two"|tee >(rev) >(tr ' ' '_')

Tee can be used to split a pipe into multiple streams for one or more process to work it. You can add more ” >()” for even more fun.

3) Duplicate several drives concurrently

dd if=/dev/sda | tee >(dd of=/dev/sdb) | dd of=/dev/sdc

If you have some drive imaging to do, you can boot into any liveCD and use a commodity machine. The drives will be written in parallel.

To improve efficiency, specify a larger block size in dd:

dd if=/dev/sda bs=64k | tee >(dd of=/dev/sdb bs=64k) | dd of=/dev/sdc bs=64kTo image more drives , insert them as additional arguments to tee:

dd if=/dev/sda | tee >(dd of=/dev/sdb) >(dd of=/dev/sdc) >(dd of=/dev/sdd) | dd of=/dev/sde
4) Save a file you edited in vim without the needed permissions (no echo)

:w !sudo tee > /dev/null %
Write a file you edited in Vim but that you do not have the permissions to write to (unless you use sudo.) Same as #1204 but without the echo to stdout that I find annoying.

5) run command on a group of nodes in parallel

echo "uptime" | tee >(ssh host1) >(ssh host2) >(ssh host3)

6) tee to a file descriptor

tee >(cat – >&2)

the tee command does fine with file names, but not so much with file descriptors, such as &2 (stderr). This uses process redirection to tee to the specified descriptor.

In the sample output, it’s being used to tee to stderr, which is connected with the terminal, and to wc -l, which is also outputting to the terminal. The result is the output of bash –version followed by the linecount

7) Add a line to a file using sudo

echo "foo bar" | sudo tee -a /path/to/some/file

This is the solution to the common mistake made by sudo newbies, since

sudo echo "foo bar" >> /path/to/some/filedoes NOT add to the file as root.

Alternatively,

sudo echo "foo bar" > /path/to/some/fileshould be replaced by

echo "foo bar" | sudo tee /path/to/some/fileAnd you can add a >/dev/null in the end if you’re not interested in the tee stdout :

echo "foo bar" | sudo tee -a /path/to/some/file >/dev/null
8) Save a file you edited in vim without the needed permissions – (Open)solaris version with RBAC

:w !pfexec tee %

9) bash or tcsh redirect both to stdout and to a file

echo "Hello World" | tee -a hello.txt

When plumbers use pipes, they sometimes need a T-joint. The Unix equivalent to this is ‘tee’. The -a flag tells ‘tee’ to append to the file, rather than clobbering it.

Tested on bash and tcsh.

10) Run a bash script in debug mode, show output and save it on a file

bash -x test.sh 2>&1 | tee out.test

Sends both stdout and stderr to the pipe which captures the data in the file ‘out.test’ and sends to stdout of tee (likely /dev/tty unless redirected). Works on Bourne, Korn and Bash shells.

11) Both view and pipe the file without saving to disk

cat /path/to/some/file.txt | tee /dev/pts/0 | wc -l

This is a cool trick to view the contents of the file on /dev/pts/0 (or whatever terminal you’re using), and also send the contents of that file to another program by way of an unnamed pipe. All the while, you’ve not bothered saving any extra data to disk, like you might be tempted to do with sed or grep to filter output.

12) Insert text at the end of a root-privileged file

echo "text" | sudo tee -a /path/file.conf > /dev/null

You can add repositories, options etc to any .conf in your system!
