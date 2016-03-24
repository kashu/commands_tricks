How do I match dot files under Unix / Linux using bash shell? Why .* considered as harmful when matching dot files under bash shell?

Short answer - .* matches the special ".." link in the directory and your command ends up getting applied to the parent directory. This may end up in unexpected results. Hence, .*considered harmful.
Long answer - Say, you want to run a chmomd/chown or find command on all of the dot files in a directory called /home/nixcraft/projects. You type the following command in $HOME/projects/ to match all dot files:

Tutorial details	
Difficulty	Easy (rss)
Root privileges	No
Requirements	Bash
Estimated completion time	N/A
chmod -R 0444 .*
OR

chown -R user:group .*

This will change the permission for both in the current and parent directory as .. will be matched by .*. This may result into unexpected security related issues and few other problems. Many Linux / Unix commands offers an option to work recursively on files. In this example, the -R option will match the current and all sub-dirs of parent directory. This can result into disaster if you have several thousand files. Restoring and cleaning from this kind of problems can be time consuming. Use the following syntax to match dot files:

 
chmod -R 0444 .[^.]*
 
OR

 
chown -R user:group .[^.]*
 
OR

 
ls -R .[^.]*
 
OR

 
find . -iname ".[^.]*" -print
 
OR

 
find . -iname ".[^.]*" -ls
 
OR

 
echo .[^.]*
echo .[^.]*/
Only match dot directories
