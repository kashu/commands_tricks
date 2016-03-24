#把当前路径下所有文件名中带有A的都替换成b
1. rename 's/A/b/' *

#把当前路径下所有123及前面是任意长度字符的文件名字删除（替换为空）
2. rename 's/.*123//' *

#使用find命令把文件的路径传递给rename进行批量改名字
3. find $PWD -name '*.avi' | rename -n 's/\[.*\]//'
reading filenames from STDIN
/home/kashu/Videos/linux_Videos/RHCE视频/RHCE视频.CD4_2/133-09[www.TopSage.com].avi renamed as /home/kashu/Videos/linux_Videos/RHCE视频/RHCE视频.CD4_2/133-09.avi
/home/kashu/Videos/linux_Videos/RHCE视频/253-01[www.TopSage.com].avi renamed as /home/kashu/Videos/linux_Videos/RHCE视频/253-01.avi
/home/kashu/Videos/linux_Videos/RHCE视频/253-03[www.TopSage.com].avi renamed as /home/kashu/Videos/linux_Videos/RHCE视频/253-03.avi


#保险起见(建议)，可以加个-n先看一下更换后的结果（实际不会修改文件名）
-n, --no-act		No Action: show what files would have been renamed.

#不加-n，立即执行修改动作。注：修改动作无法返回的！
4. find $PWD -name '*.avi' | rename 's/\[.*\]//'

#文件名以"第"开头的字全部删除
5. rename 's/^第//' *.pdf

6. find . -name 'EnglishPod.Intro.*' -exec rename -n 's/EnglishPod\.Intro\.//' {} \;

7. find . -name 'englishpod_*' -exec rename -n 's/englishpod\_//' {} \;

8. rename -n 's/\[ç©ºä¸\­è‹±è¯\­æ•™å®¤\]\[Studio\.Classroom\]//' *

9. rename -n 's/^/CD3_/' *

10.rename -n 's/(第|讲)//g' *.7z

#find命令与rename的配合
11.find -regextype posix-extended -regex '.*/[0-9][0-9] .*'  | sort | rename -n 's/\.\//0/g'

