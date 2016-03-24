One of the great things about Linux is that you can do the same thing hundreds of different ways—even something as simple as generating a random password can be accomplished with dozens of different commands. Here’s 10 ways you can do it.

We gathered all of these commands from Command-Line Fu and tested them out on our own Linux PC to make sure they work. You should be able to use at least some of these on Windows with Cygwin installed, though we didn’t test all of them—the last one definitely works though.

Generate a Random Password
For any of these random password commands, you can either modify them to output a different password length, or you can just use the first x characters of the generated password if you don’t want such a long password. Hopefully you’re using a password manager like LastPass anyway so you don’t need to memorize them.

This method uses SHA to hash the date, runs through base64, and then outputs the top 32 characters.

date +%s | sha256sum | base64 | head -c 32 ; echo
This method used the built-in /dev/urandom feature, and filters out only characters that you would normally use in a password. Then it outputs the top 32.

< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
This one uses openssl’s rand function, which may not be installed on your system. Good thing there’s lots of other examples, right?

openssl rand -base64 32
This one works a lot like the other urandom one, but just does the work in reverse. Bash is very powerful!

tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1
Here’s another example that filters using the strings command, which outputs printable strings from a file, which in this case is the urandom feature.

strings /dev/urandom | grep -o ':alnum:' | head -n 30 | tr -d '\n'; echo
Here’s an even simpler version of the urandom one.

< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c6
This one manages to use the very useful dd command.

dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev
You can even create a random left-hand password, which would let you type your password with one hand.

</dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c8; echo ""
If you’re going to be using this all the time, it’s probably a better idea to put it into a function. In this case, once you run the command once, you’ll be able to use randpw anytime you want to generate a random password. You’d probably want to put this into your ~/.bashrc file.

randpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;}
You can use this same syntax to make any of these into a function—just replace everything inside the { }

And here’s the easiest way to make a password from the command line, which works in Linux, Windows with Cygwin, and probably Mac OS X. I’m sure that some people will complain that it’s not as random as some of the other options, but honestly, it’s random enough if you’re going to be using the whole thing.

date | md5sum
Yeah, that’s even easy enough to remember.

There’s loads of other ways that you can create a random password from the command line in Linux—for instance, the mkpasswd command, which can actually assign the password to a Linux user account. So what’s your favorite way?
