ccze is a wonderful tool that brings real joy to the arduous task of reading or searching thru log files. #nerdalert
We’ve been using ccze for years but recently stumbled (um, actually, rtfm’d) upon the “missing” feature – the ability to output the colorized results in a format that can be piped to grep.
tail -f /var/log/syslog | ccze -A | grep login will result in grep results made pretty and readable by ccze – not revolutionary, but very handy. And pretty.

ccze -A < /path/to/log/file | less -R

ccze also colorizes  ruby, apache, dhcp and most other types of log files and data files, try it out, you’ll be happy you did!

Notes:
Get ccze on OS X with: brew install ccze
Install ccze on Ubuntu / Debian with: apt-get install ccze
ccze -h will give you HTML output
Below is a quick video showing tail -f on an active DHCP server log with and without ccze.

http://blog.tersmitten.nl/wp-content/uploads/2010/05/colored-logs1.png
