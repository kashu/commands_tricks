# sh -c "ifconfig eth0 | egrep ask; ls /home; id -un; echo hello"
          inet addr:10.148.149.71  Bcast:10.148.149.255  Mask:255.255.255.0
user1  user2  user3
root
hello

# for s in `sh -c "sort -t: -k3 -h /etc/passwd | head -n 5 | cut -d: -f1"`; do id $s; done
uid=0(root) gid=0(root) groups=0(root)
uid=1(bin) gid=1(bin) groups=1(bin),2(daemon),3(sys)
uid=2(daemon) gid=2(daemon) groups=2(daemon),1(bin),4(adm),7(lp)
uid=3(adm) gid=4(adm) groups=4(adm),3(sys)
uid=4(lp) gid=7(lp) groups=7(lp)

