$ findmnt
TARGET                       SOURCE                   FSTYPE           OPTIONS
/                            /dev/mapper/lvmVG-lvroot ext4             rw,noatime,nodiratime,errors=remount-ro,data=ordered
├─/sys                       sysfs                    sysfs            rw,nosuid,nodev,noexec,relatime
│ ├─/sys/fs/cgroup                                    tmpfs            rw,relatime,size=4k,mode=755
│ │ └─/sys/fs/cgroup/systemd systemd                  cgroup           rw,nosuid,nodev,noexec,relatime,name=systemd
│ ├─/sys/fs/fuse/connections                          fusectl          rw,relatime
│ ├─/sys/kernel/debug                                 debugfs          rw,relatime
│ ├─/sys/kernel/security                              securityfs       rw,relatime
│ └─/sys/fs/pstore                                    pstore           rw,relatime
├─/proc                      proc                     proc             rw,nosuid,nodev,noexec,relatime
│ └─/proc/sys/fs/binfmt_misc binfmt_misc              binfmt_misc      rw,nosuid,nodev,noexec,relatime
├─/dev                       udev                     devtmpfs         rw,relatime,size=6088468k,nr_inodes=1522117,mode=755
│ └─/dev/pts                 devpts                   devpts           rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
├─/run                       tmpfs                    tmpfs            rw,nosuid,noexec,relatime,size=1219932k,mode=755
│ ├─/run/lock                                         tmpfs            rw,nosuid,nodev,noexec,relatime,size=5120k
│ ├─/run/shm                                          tmpfs            rw,nosuid,nodev,relatime
│ ├─/run/user                                         tmpfs            rw,nosuid,nodev,noexec,relatime,size=102400k,mode=755
│ │ └─/run/user/1000/gvfs    gvfsd-fuse               fuse.gvfsd-fuse  rw,nosuid,nodev,relatime,user_id=1000,group_id=1000
│ └─/run/vmblock-fuse        vmware-vmblock           fuse.vmware-vmbl rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_ot
├─/tmp                       tmpfs                    tmpfs            rw,nosuid,nodev,noatime,nodiratime,size=6099644k
├─/boot                      /dev/sda1                ext4             rw,noatime,nodiratime,data=ordered
└─/home                      /dev/mapper/lvmVG-lvhome ext4             rw,noatime,nodiratime,data=ordered

$ findmnt -text4
TARGET SOURCE                   FSTYPE OPTIONS
/      /dev/mapper/lvmVG-lvroot ext4   rw,noatime,nodiratime,errors=remount-ro,data=ordered
/boot  /dev/sda1                ext4   rw,noatime,nodiratime,data=ordered
/home  /dev/mapper/lvmVG-lvhome ext4   rw,noatime,nodiratime,data=ordered

$ findmnt /dev/sda1
TARGET SOURCE    FSTYPE OPTIONS
/boot  /dev/sda1 ext4   rw,noatime,nodiratime,data=ordered

$ findmnt /
TARGET SOURCE                   FSTYPE OPTIONS
/      /dev/mapper/lvmVG-lvroot ext4   rw,noatime,nodiratime,errors=remount-ro,data=ordered

