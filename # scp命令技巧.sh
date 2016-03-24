Edit a file on a remote host using vim

# vim scp://username@host//path/to/somefile
Colored diff ( via vim ) on 2 remotes files on your local computer.

# vimdiff scp://root@server-foo.com//etc/snmp/snmpd.conf scp://root@server-bar.com//etc/snmp/snmpd.conf
Restrict the bandwidth for the SCP command

scp -l10 user@urfix.com:/home/urfix/* .
the command is obvious, I know, but maybe not everyone knows that using the parameter “-l” you can limit the use of bandwidth command scp.
In this example fetch all files from the directory zutaniddu and I copy them locally using only 10 Kbs

Compare a remote file with a local file

# vimdiff  scp://[@]/
Easily scp a file back to the host you’re connecting from

# mecp () { scp "$@" ${SSH_CLIENT%% *}:Desktop/; }
Place in .bashrc and invoke like this: “mecp /path/to/file”, and it will copy the specified file(s) back to the desktop of the host you’re ssh’ing in from. To easily upload a file from the host you’re ssh’ing in from use this:

# ucp (){ scp ${SSH_CLIENT%% *}:Desktop/upload/* .; }
scp file from hostb to hostc while logged into hosta

# scp user@hostb:file user@hostc:
While at the command line of of hosta, scp a file from remote hostb to remote hostc. This saves the step of logging into hostb and then issuing the scp command to hostc.

Copy something to multiple SSH hosts with a Bash loop

# for h in host1 host2 host3 host4 ; { scp file user@$h:/destination_path/ ; }
Just a quick and simple one to demonstrate Bash For loop. Copies ‘file’ to multiple ssh hosts.

scp with compression.

# scp -C 10.0.0.4:/tmp/backup.sql /path/to/backup.sql
-C is for compression.
