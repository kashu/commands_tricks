In this tutorial we will see some useful FFMPEG commands that you can use on Ubuntu/Linux Mint to make screencasting videos, rotate videos, add logo/text watermarks to a video, insert shapes, and so on.

To install ffmpeg and some other packages on Ubuntu/Linux Mint, open the terminal and run these commands:

sudo apt-get install ubuntu-restricted-extras

sudo apt-get install ffmpeg x264

sudo apt-get install frei0r-plugins mjpegtools

Note: The file formats used in this tutorial are selected randomly and you can set any other extension of your choice.

1. Screecasting

To record your screen withh FFMPEG, you can use this command:

ffmpeg -f x11grab -follow_mouse 100 -r 25 -s vga -i :0.0 filename.avi

Now the command will record every spot on your screen you hover your mouse cursor over. Press Ctrl+C to stop recording. If you want to set a screen resolution for the video to be recorded, you can use this ffmpeg command:

ffmpeg -f x11grab -s 800x600 -r 25 -i :0.0 -qscale 5 filename.avi

To show the region that will be recorded while moving your mouse pointer, use this command:

ffmpeg -f x11grab -follow_mouse centered -show_region 1 -r 25 -s vga -i :0.0 filename.avi

If you want to record in fullscreen with better video quality (HD), you can use this command:

ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq  video.mp4

Her is a video example created with the latter command:


2. Add Audio To A Static Picture
If you want to add music to a static picture with ffmpeg, run this command from the terminal:
ffmpeg -i audio.mp3 -loop_input -f image2 -i file.jpg -t 188 output.mp4

3. Add Image Watermarks to A Video
To add an image to a video using ffmpeg, you can use one of these commands:

Picture Location: Top Left Corner
ffmpeg -i input.avi -vf "movie=file.png [watermark]; [in][watermark] overlay=10:10 [out]" output.flv

Here is an example:
Picture Location: Top Right Corner
ffmpeg –i input.avi -vf "movie=watermarklogo.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:10 [out]" output.flv

Picture Location: Bottom Left Corner
ffmpeg –i input.avi -vf "movie=watermarklogo.png [watermark]; [in][watermark] overlay=10:main_h-overlay_h-10 [out]" output.flv

Picture Location: Bottom Right Corner
ffmpeg –i input.avi -vf "movie=watermarklogo.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:main_h-overlay_h-10 [out]" output.flv

4. Add Text Watermarks To Videos

To add text to a video, use this command:
ffmpeg -i input.mp4 -vf drawtext="fontfile=/usr/share/fonts/truetype/freefont/FreeSans.ttf: text='YOUR TEXT HERE':fontcolor=red@1.0:fontsize=70:x=00: y=40" -y output.mp4

An example:

To use another text font, you can list them from the terminal with this command:
ls /usr/share/fonts/truetype/freefont/

4. Rotate Videos

To rotate a video 90 degrees with ffmpeg, run this command:
ffmpeg -i input.avi -vf transpose=1 output.avi

Here is an example for a video rotated with ffmpeg:


Here is all parameters:

0 = 90 degrees CounterCLockwise  (Vertical Flip (default))
1 = 90 degrees Clockwise
2 = 90 degrees CounterClockwise
3 = 90 degrees Clockwise (Vertical Flip)

5. Adjust Audio/Video Volume
You can use ffmpeg to change volume of a video file with this command:
ffmpeg -i input.avi -vol 100  output.avi

To change volume of an audio file, run this command:
ffmpeg -i input.mp3 -vol 100 -ab 128 output.mp3

6. Insert A Video Inside Another Video

To do this, run this command:
ffmpeg -i video1.mp4 -vf "movie=video2.mp4:seek_point=5, scale=200:-1, setpts=PTS-STARTPTS [movie]; [in] setpts=PTS-STARTPTS, [movie] overlay=270:240 [out]" output.mp4

Here is an example:


7. Add a Rectangle To A Video
To draw for example an orange rectangle in a video, you can use this command:
ffmpeg -i input.avi -vf "drawbox=500:150:600:400:orange@0.9" -sameq -y output.avi

Video example:


If you have something to add or report a mistake, please use the comment form below.
from:http://www.upubuntu.com/2012/10/some-useful-ffmpeg-commands.html






这里裁剪是指时间轴裁剪，不是空间裁剪。
比如说，你想从某个视频的1分20秒位置开始，其后面30秒长度的视频裁剪出来，保存成另一个视频。
##########################################################################################
一、裁剪视频 
用这个：
ffmpeg -i 1.mp4 -ss 00:01:20 -t 00:00:30 -c:a copy -c:v copy 2.mp4
等同于：
ffmpeg -i 1.mp4 -ss 00:01:20 -t 00:00:30 -acodec copy -vcodec copy 2.mp4

从视频的32分18秒位置，一直到视频末尾：
ffmpeg -i 1.mp4 -ss 00:32:18 -sseof 0 -c:a copy -c:v copy 2.mp4

有的视频中会包含多个数据流（如：以mkv格式封装的视频）
1）先用ffmpeg -i 1.mkv查看一下该视频对应的视频流； 
2）确定需要保留哪些视频流；
3）用-map 0:0、-map 0:2来指定需要保留的数据流，并且-c copy复制
ffmpeg -i 1.mkv -map 0:0 -map 0:2 -map 0:4 -c copy 2.mkv

先用ffmpeg -i 1.mkv查看一下该视频中有哪些数据流，并确定下来哪些需要保留
ffmpeg -i 1.mkv
Input #0, matroska,webm, from '1.mkv':
  第1个数据流是视频：
    Stream #0:0(jpn): Video: h264 (High), yuv420p, 704x396, SAR 1:1 DAR 16:9, 29.97 fps, 29.97 tbr, 1k tbn, 59.94 tbc (default)
      title           : Lover in Law 1 (h264)
  第2个数据流是音频：
    Stream #0:1(rus): Audio: vorbis, 48000 Hz, stereo, fltp (default)
      title           : DJ ATOM
  第3个数据流是音频：
    Stream #0:2(jpn): Audio: vorbis, 48000 Hz, stereo, fltp
      title           : Original
  第4个数据流是音频：
    Stream #0:3(eng): Audio: vorbis, 48000 Hz, stereo, fltp
  第5个数据流是字幕：
    Stream #0:4(eng): Subtitle: ass
      title           : ass
  第6个数据流是字体文件：
    Stream #0:5: Attachment: ttf
      filename        : Montara-Gothic.otf
  第7个数据流是字体文件：
    Stream #0:6: Attachment: ttf
      filename        : ARRBD_ECL.ttf

然后，就得到一个新视频文件（把其它不需要的数据流给剔除了）
ffmpeg -i test.mkv
  Duration: 00:23:27.99, start: 0.000000, bitrate: 1205 kb/s
    Stream #0:0(jpn): Video: h264 (High), yuv420p, 704x396, SAR 1:1 DAR 16:9, 29.97 fps, 29.97 tbr, 1k tbn, 59.94 tbc (default)
      title           : Lover in Law 1 (h264)
    Stream #0:1(jpn): Audio: vorbis, 48000 Hz, stereo, fltp
      title           : Original
    Stream #0:2(eng): Subtitle: ass
      title           : ass


ffmpeg提供简单的命令参数：
ffmpeg -ss START -to DURATION -i INPUT -vcodec copy -acodec copy OUTPUT
对上面的命令稍做个解释。
-ss 开始时间，如： 00:00:20，表示从20秒开始；
-to 时长，如： 00:00:10，表示截取10秒长的视频；
-i 输入，后面是空格，紧跟着就是输入视频文件；
-vcodec copy 和 -acodec copy表示所要使用的视频和音频的编码格式，这里指定为copy表示原样拷贝；
INPUT，输入视频文件；
OUTPUT，输出视频文件；
-sseof 0，表示到视频文件末尾
 
比如：
ffmpeg -ss 00:00:20 -i kashu.mp4 -vcodec copy -acodec copy -to 00:00:10 kashu.org.mp4
这个命令就是从20秒开始裁剪到20+10=30秒结束，总共10秒的视频。这个命令执行很快，因为只是原始数据的拷贝，中间没有什么编码和解码的过程。
执行这个命令后你能得到kashu.org.mp4这个输出文件。你可以用视频播放软件播放这个视频看看。可能有些视频裁剪后的效果，如期望一致，20秒开始，30秒结束，总共10秒的视频，但是有些视频裁剪后你会发现可能开始和结束都不是很准确，有可能是从18秒开始，33秒结束。这是为什么呢？
因为这些视频里20秒和30秒处地方刚好不是关键帧，而ffmpeg会在你输入的这两个时间点附近圆整到最接近的关键帧处，然后做接下来的事情。如果你不懂什么是关键帧，没关系，这也不影响你使用这个命令。

如果你的要求能够接受几秒的误差，那么这个命令完全就可以满足你的需要，接下来的内容你也没有必要往下看了。

但是在我项目里要求很严格，一定要到确定的时间。所以要用另外一种方式。
上面的造成那样的原因是所选的时间不是关键帧，那如果我们将输入的视频先转换成所有的帧都为关键帧的视频，其实就是将所有的帧的编码方式转为帧内编码（不理解帧内编码也没关系，你就当没看见它，接着往下看），这个问题就有解了。ffmpeg也可以帮我们完成这个事情。

ffmpeg -i INPUT -sameq -intra OUTPUT
-i 输入，后面是空格，紧跟着就是输入视频文件；
INPUT 输入文件；
-sameq 表示保持同样的视频质量；
-intra， 帧内编码；
OUTPUT 输出文件名。
 
如：
ffmpeg -i www.kashu.org.mp4 -sameq -intra kashu.org.mp4
这个命令的结果文件就是kashu.org.mp4。这个文件的视频和www.kashu.org.mp4是一样的，但是你会发现这个文件会比www.kashu.org.mp4大很多倍，原因就是转换前一般采用的帧间编码，转换后变成了帧内编码。这里我们说是一般，原因是有些视频文件本身就采用了帧内编码。
 
接下来我们就开始裁剪
ffmpeg -ss START -vsync 0 -i INPUT -vcodec VIDEOCODEC-acodec AUDIOCODEC -to DURATION OUTPUT
ffmpeg -ss 00:16:25 -vsync 0 -i FHD.mp4 -vcodec copy -acodec copy -to 00:57:06 2FHD.mp4
-ss 开始时间，如： 00:00:20，表示从20秒开始；
-to 时长，如： 00:00:10，表示截取10秒长的视频；
-i 输入，后面是空格，紧跟着就是输入视频文件；
-vcodec 视频的编码格表示所要使用的视频式；
-acodec 音频的编码格表示所要使用的视频式；
INPUT，输入视频文件；
OUTPUT，输出视频文件；
 
如：
ffmpeg -ss 00:00:30 -vsync 0 -i kashu.org.mp4 -vcodec libx264-acodec libfaac -to 00:00:30 www.kashu.org.mp4
这里音频和视频分别采用了aac和h264.这样就得到了我们最终想要的结果。


视频裁剪
剪切的同时，格式不变，音视频参数不变：
ffmpeg -y -i bjysxyt5.mp4 -ss 00:00:00.0 -t 00:01:00.0 -acodec copy -vcodec copy bjysxyt1.mp4

剪切的同时，音视频参数不变，只转换格式：
fmpeg -y -i bjysxyt5.mp4 -ss 00:00:00.0 -t 00:01:00.0 -acodec copy -vcodec copy bjysxyt1.flv

剪切的同时，格式不变，只转换音视频参数：
ffmpeg -y -i bjysxyt5.mp4 -ss 00:00:00.0 -t 00:01:00.0 -ab 56k -ar 44100 -b:v 2200k -r 29.97 -s 640x360 bjysxyt1.mp4

剪切的同时，既转换格式又转换音视频参数：
ffmpeg -y -i bjysxyt5.mp4 -ss 00:00:00.0 -t 00:01:00.0 -ab 56k -ar 44100 -b:v 2200k -r 29.97 -s 640x360 bjysxyt1.flv

说明：-i表示输入文件；-acodec copy -vcodec copy 表示音频、视频不进行编解码，直接复制源视频；-ss表示起始时间，-t表示时长，格式均为“小时：分钟：秒”。

##########################################################################################
二、合并视频
上面我们可以将一个视频中感兴趣的部分裁剪出来，比如我们裁剪出3段视频，而裁剪出来的视频，我们不想它是一个一个的，而是一整个。总的需求就是给定一个视频，用户可以挑选出自己喜欢的一些时间段，然后开始裁剪，最后得到那些挑选的时间段组成的视频。
 
要完成这个任务，有了前面我们裁剪视频的基础就好办多了，利用前面的方法将各个感兴趣的视频裁剪出了，这样得到多个小视频，然后再用下面的方法就可以实现：
现在这里声明一下，下面红色的部分是我早之前的版本，是错误，因此误导了大家，非常的抱歉。
所以直接忽略红色的部分，看后面的内容
  
合并成一个完整的视频：
ffmpeg -i INPUT1 -i INPUT2 -f FORMAT -acodec AUDIOCODEC -vcodec VIDEOCODEC -sameq OUTPUT
这里的几乎所有用到的参数已经在上面做过解释，除了-f.
-f FORMAT, 表示视频的格式。如-f MP4, 那么我们的视频格式就是MP4。

另外，你几个想要的合并的视频就加入几个-i [Input file], 例如下面我有2个视频要合并.
ffmpeg -i MyVideo1.avi -i MyVideo2.avi -f mp4 -acodec libfaac -vcodec libx264 -sameq Result.avi 
这里的Result.avi, 你也可以改成是Result.mp4， 也没有问题。

如果你发现执行完上面的命令后，结果视频（result.avi）不是2个视频的合并，可能是前面你合并视频的时候2个视频的格式不一致导致，或者你所使用ffmpeg的版本有这个bug，你可以换下面的方法再尝试。
1. 将要合并的视频先转换成统一的格式，包括编码格式，帧率，尺寸。
ffmpeg -i [input] -f mpeg -r 25 [out]
 
2. 让后用copy或者cat命令合并。

1. 首先将各个视频全部转换为mpeg格式：
ffmpeg  -i INPUT -f mpeg  OUTPUT
例如：
ffmpeg  -i temp1.avi -f mpeg  result1.mpg
ffmpeg  -i temp2.mp4 -f mpeg  result2.mpg

2. 通过copy或者cat命令合并视频
copy -b INPUT+INPUT OUTPUT
例如：
copy /b "result1.mpg"+"result1.mpg" "result.mpge" 

3. 将合并的视频进行编码生成最终的结果视频
ffmpeg -i INPUT -f FORMAT OUTPUT
例如：
ffmpeg -i "result.mpge" -f mp4 "result.mp4"

4. 使用ffmpeg合并MP4文件
ffmpeg -i "Apache Sqoop Tutorial Part 1.mp4" -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate1.ts
ffmpeg -i "Apache Sqoop Tutorial Part 2.mp4" -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate2.ts
ffmpeg -i "Apache Sqoop Tutorial Part 3.mp4" -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate3.ts
ffmpeg -i "Apache Sqoop Tutorial Part 4.mp4" -c copy -bsf:v h264_mp4toannexb -f mpegts intermediate4.ts
ffmpeg -i "concat:intermediate1.ts|intermediate2.ts|intermediate3.ts|intermediate4.ts" -c copy -bsf:a aac_adtstoasc "Apache Sqoop Tutorial.mp4"

5. 「无损」合并flv文件（其它格式应该也可以）
FFmpeg concat 分离器
这种方法成功率很高，也是最好的，但是需要 FFmpeg 1.1 以上版本。先创建一个文本文件 filelist.txt：
file 'input1.flv'
file 'input2.flv'
file 'input3.flv'
然后：
ffmpeg -f concat -i filelist.txt -c copy output.flv
注意：使用 FFmpeg concat 分离器时，如果文件名有奇怪的字符，要在 filelist.txt 中转义。

##########################################################################################
ffmpeg（版本3.0.0）虽然能把Windows Media Video 9(wmv3) 转码成 HEVC(h.265)，但转完后的画质不好，无论preset设置成ultrafast还是veryslow，画质都不好（转的是一个动画）

三、视频格式转换
使用ffmpeg转换flv到mp4
ffmpeg -i INPUT.flv -vcodec copy -acodec copy out.mp4

转换到HEVC(h.265)视频编码格式：
ffmpeg -i INPUT.video -c:a copy -c:v libx265 OUTPUT.h265.mkv

转换到HEVC(h.265)视频编码格式(有时想预览一下转换后的效果，但不可能整个视频全部转换完，这样会太费时间。所以，只截取从视频首部位置开始的30秒长度的视频，来作为转换的样本)：
ffmpeg -i INPUT.video -c:a copy -c:v libx265 -ss 00:00:00 -to 00:00:30 OUTPUT.mkv

使用预设中最好的压缩质量（速度相对慢一点），音频格式转换成mp3，视频编码格式转换成HEVC(h.265)，从视频的第10分钟开始截取，只截取50秒长度的视频
ffmpeg -i INPUT.video -c:a mp3 -c:v libx265 -ss 00:10:00 -to 00:00:50 -preset veryslow OUTPUT.mkv

##########################################################################################
四、使用ffmpeg截图
ffmpeg -ss 00:10:00 -i "Apache Sqoop Tutorial.mp4" -y -f image2 -vframes 1 test.png
或
ffmpeg -ss 10 -i input.flv -y -f image2  -vframes 100 -s 352x240 b-%03d.jpg
ffmpeg -i test.mp4 -y -f mjpeg -ss 3 -t 1  test1.jpg
ffmpeg -i test.mp4 -y -f image2 -ss 3 -vframes 1 test1.jpg
上面二个例子都表示，在第三秒的时候，截图。

参数解释:
-i  输入文件
-y  覆盖
-f  生成图片格式
-ss 开始截图时间 seconds or in hh:mm:ss[.xxx] 如果截图开始时间越接近篇尾，所花费的时间就会越长
-vframes  截图帧数 或者 使用 -t : 截图时长 seconds, or hh:mm:ss[.xxx]
-s  图片宽高比
b-%3d.jpg 格式化文件命名,会生成 b-001.jpg，b-002.jpg 等。
注意：把-ss 10放到第一个参数的位置，速度比放到放到其他位置快，且不会出现如下错误

每隔一秒截一张图
ffmpeg -i out.mp4 -f image2 -vf fps=fps=1 out%d.png

每隔20秒截一张图
ffmpeg -i out.mp4 -f image2 -vf fps=fps=1/20 out%d.png

多张截图合并到一个文件里（2x3）每隔一千帧(秒数=1000/fps25)即40s截一张图
ffmpeg -i out.mp4 -frames 3 -vf "select=not(mod(n\,1000)),scale=320:240,tile=2x3" out.png

从视频中生成GIF图片
ffmpeg -i out.mp4 -t 10 -pix_fmt rgb24 out.gif

转换视频为图片（每帧一张图）
ffmpeg -i out.mp4 out%4d.png

图片转换为视频
ffmpeg -f image2 -i out%4d.png -r 25 video.mp4


五、视频中嵌入字幕（字幕用utf-8编码）
用这种方法嵌入的字幕，视频在播放时字幕不会一同自动播放显示（ffmpeg不会把字幕设置为默认的subtitle track），而是播放时要在播放器里手工点选字幕，但这种字幕的嵌入速度极快
ffmpeg -i input.mp4 -i subtitles.srt -c:s mov_text -c:v copy -c:a copy output.mp4
ffmpeg -i 1.mkv -i "subtitle 1.ass" -c:s ass -c:v copy -c:a copy 2.mkv
另，附：ffmpeg -i in.mp4 -i in.srt -c copy -disposition:s:0 default out.mkv（有人说加个default可设为默认，本人还没有实测过）

如果希望字幕直接显示出来，也可以实现（用此方法嵌入的字幕，不是单独的字幕流，而是直接改写视频流。因此在播放该视频时，字幕也会一同自动播放出来。不用像上面那样手工点选字幕才能显示）
ffmpeg -i subtitle.srt subtitle.ass（把srt转换成ass的字幕，我觉得一般不需要转吧，因为ffmpeg都支持的）
ffmpeg -i input.mp4 -c:a copy -vf ass=subtitle.ass output.mp4
ffmpeg -i 2.mkv -c:a copy -vf ass="h3\ \[KH\]_Maid_in_Heaven_02\ \(h264\)_\[B43F8094\].ass" 3.mkv
（注：音频数据流不能用-c:a copy，不然会报错：Filtering and streamcopy cannot be used together.)
（注：这样生成出来的视频体积较小，视频画质方面是否会有明显的降低，生成后请和原始视频仔细对比，自己权衡。个人觉得，画面颜色深度有些降低）
（注：ass=后面跟的文件名路径如果有空格等特殊符号，一定要用\转义）

六、视频的缩放（补充 ）
Scale filter调整分辨率
Scale filter的优点是可以使用一些额外的参数
语法：
Scale=width:height[:interl={1|-1}]
下表列出了常用的额外参数
举例
下面两条命令有相同效果
ffmpeg -i input.mpg -s 320x240 output.mp4 
ffmpeg -i input.mpg -vf scale=320:240 output.mp4
 
对输入视频成比例缩放
改变为源视频一半大小
ffmpeg -i input.mpg -vf scale=iw/2:ih/2 output.mp4
改变为原视频的90%大小：
ffmpeg -i input.mpg -vf scale=iw*0.9:ih*0.9 output.mp4

参数 scale=853:480 当中的宽度和高度实际应用场景中通常只需指定一个，比如指定高度为 480 或者 720，至于宽度则可以传入 “-1” 表示由原始视频的宽高比自动计算而得。即参数可以写为：scale=-1:480，当然也可以 scale=480:-1
ffmpeg -i 4.mp4 -c:a copy -c:v libx264 -preset ultrafast -vf scale=iw*0.5:ih*0.5 4.720p.mp4
ffmpeg -i 4.mp4 -c:a copy -c:v libx264 -preset ultrafast -vf scale=-1:ih*0.4 4.0.4.mp4


   我们在将多种格式的视频转换成flv格式的时候，我们关注的就是转换后的flv视频的品质和大小。下面就自己的实践所得来和大家分享一下，主要针对avi、3gp、mp4和wmv四种格式来进行分析。通常在使用ffmpeg进行视频转换的时候我们使用到的控制音视频的主要参数有如下：
-ab      bitrate      设置音频码率
-acodec  codec        使用codec编解码
-ac      channels     设置通道,缺省为1
-ar      freq         设置音频采样率
-r       fps          设置帧频,缺省25
-b       bitrate      设置比特率,缺省200kb/s
-qscale  6或4         使用动态码率来设置
    对于其他诸如-i、-y、-s等参数基本上都是可以很好理解的了。我们上面提到的几个参数前四个主要是用来设置音频的，后三个主要是用来设置视频的。对于音频的ar（采样率）可以指定为22050、24000、44100或48000，一般来将后两种比较常见；对于音频的ab（码率）一般是选择32、64、96或128这几种；对音频的acodec则是指定编码方式，可以指定为libmp3lame或aac等，这两种分别是指使用mp3和aac格式的音频。在实际的测试过程中我发现在使用mp3进行音频编码时指定ab为64或更高和指定ar为22050或更高对实际的视频音质没有什么大的影响，请参见后面的测试结果。

    对于视频的r用来指定帧频，一般设置为29.97；对于视频的b（视频的比特率）可以指定如128、314等数字，对于1500以上则没有效果；对于视频的qscale，属于动态码率，可以设置为4或6，4的质量比6的要高。在测试的过程中我发现设置-b参数对视频的质量并没有过大的改变（指定大指定小都差不多或是一样），而设置qscale则完全不一样，如果我们想获取高品质的话应该使用动态码率而不是指定-b参数，当然了，使用动态码率的坏处就是视频的体积变大了。在使用动态码率的时候使用6的效果和4差不多，但是体积减少了，因此通常建议使用6来设置动态码率。

    上面介绍了转换过程中的音视频的配置参数，综合上面，我们在转换的时候通常的命令如下：
高品质：ffmpeg -i infile -ab 128 -acodec libmp3lame -ac 1 -ar 22050 -r 29.97 -qscale 6 -y outfile
低品质：ffmpeg -i infile -ab 128 -acodec libmp3lame -ac 1 -ar 22050 -r 29.97 -b 512 -y outfile

使用这两个命令测试四种格式的视频结果如下，同时在测试的过程中会改变相应的参数进行测试，四个视频的信息如下：
AVI格式的：test.avi      14.1M
3GP格式的：test.3gp      4.30M
MP4格式的：test.mp4      16.4M
WMV格式的：test.wmv      15.0M

1.使用高品质的脚本测试结果如下：
AVI格式转换后的：-qscale 6结果=avi_01.flv   6.61M      -qscale 4结果=avi_02.flv   9.30M
3GP格式转换后的：-qscale 6结果=3gp_01.flv   4.21M      -qscale 4结果=3gp_02.flv   5.30M
MP4格式转换后的：-qscale 6结果=mp4_01.flv   13.1M      -qscale 4结果=mp4_02.flv   17.5M
WMV格式转换后的：-qscale 6结果=wmv_01.flv   15.9M      -qscale 4结果=wmv_02.flv   22.3M

2.使用低品质的脚本测试结果如下：
AVI格式转换后的：-b 512结果=avi_03.flv   2.87M      -b 1000结果=avi_04.flv   2.87M
3GP格式转换后的：-b 512结果=3gp_03.flv   1.73M      -b 1000结果=3gp_04.flv   1.73M
MP4格式转换后的：-b 512结果=mp4_03.flv   5.84M      -b 1000结果=mp4_04.flv   5.84M
WMV格式转换后的：-b 512结果=wmv_03.flv   6.17M      -b 1000结果=wmv_04.flv   6.17M

3.压缩率比较如下：
AVI格式转换后的：-qscale 6结果=53.12%   -qscale 4结果=34.04%   -b 512/1000结果=79.65%
3GP格式转换后的：-qscale 6结果=2.093%   -qscale 4结果=123.1%   -b 512/1000结果=59.77%
MP4格式转换后的：-qscale 6结果=20.12%   -qscale 4结果=106.7%   -b 512/1000结果=64.39%
WMV格式转换后的：-qscale 6结果=106.0%   -qscale 4结果=148.7%   -b 512/1000结果=58.87%

    通过比较前后的压缩大小我们可以看到在音频保持一致的情况下，使用高品质的转换和使用低品质的转换的巨大差异，同时对于不同格式的视频在转换的过程中也会出现比较大的差异。当然了，这些数据并不一定代表所有这些格式的视频都是如此，具体的要看大家的应用了。不过，我们可以确定的是AVI格式的视频在转换成FLV格式后其压缩率最大，不过对于不同编码的AVI其结果就不一定了。同时我们也还看到，对于某些格式的视频在转换后其体积比原先的还大了，这个我们在应用的时候就需要注意了。

    这里没有测试RM和RMVB格式的，因为ffmpeg无法直接转换这两种格式的视频，下次我将使用mencoder来测试转换RM和RMVB格式的视频为FLV的分析。以下是转换前后截取的图片，可以参考看一下.
1.AVI格式截取前、使用-qscale 6和-b 512三个的截图分别如下:
2.3GP格式截取前、使用-qscale 6和-b 512三个的截图分别如下:
3.MP4格式截取前、使用-qscale 6和-b 512三个的截图分别如下:
4.WMV格式截取前、使用-qscale 6和-b 512三个的截图分别如下:
