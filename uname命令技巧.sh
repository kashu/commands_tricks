uname

#Print certain system information.  With no OPTION, same as -s.

  -a, --all                print all information, in the following order,
                             except omit -p and -i if unknown:
  -s, --kernel-name        print the kernel name
  -n, --nodename           print the network node hostname
  -r, --kernel-release     print the kernel release
  -v, --kernel-version     print the kernel version
  -m, --machine            print the machine hardware name
  -p, --processor          print the processor type or "unknown"
  -i, --hardware-platform  print the hardware platform or "unknown"
  -o, --operating-system   print the operating system
      --help               display this help and exit

#示例
$ uname -a
Linux kashu 3.13.0-51-generic #84-Ubuntu SMP Wed Apr 15 12:08:34 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

$ uname -r
3.13.0-51-generic

$ uname -m
x86_64

$ uname -o
GNU/Linux

