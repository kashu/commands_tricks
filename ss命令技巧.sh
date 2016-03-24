ss

#ss [ OPTIONS ] [ FILTER ]
   -h, --help		this message
   -V, --version	output version information
   -n, --numeric	don't resolve service names
   -r, --resolve       resolve host names
   -a, --all		display all sockets
   -l, --listening	display listening sockets
   -o, --options       show timer information
   -e, --extended      show detailed socket information
   -m, --memory        show socket memory usage
   -p, --processes	show process using socket
   -i, --info		show internal TCP information
   -s, --summary	show socket usage summary
   -b, --bpf           show bpf filter socket information

   -4, --ipv4          display only IP version 4 sockets
   -6, --ipv6          display only IP version 6 sockets
   -0, --packet	display PACKET sockets
   -t, --tcp		display only TCP sockets
   -u, --udp		display only UDP sockets
   -d, --dccp		display only DCCP sockets
   -w, --raw		display only RAW sockets
   -x, --unix		display only Unix domain sockets
   -f, --family=FAMILY display sockets of type FAMILY

   -A, --query=QUERY, --socket=QUERY
       QUERY := {all|inet|tcp|udp|raw|unix|packet|netlink}[,QUERY]

   -D, --diag=FILE     Dump raw information about TCP sockets to FILE
   -F, --filter=FILE   read filter information from FILE
       FILTER := [ state TCP-STATE ] [ EXPRESSION ]

sudo ss -tunap | col


