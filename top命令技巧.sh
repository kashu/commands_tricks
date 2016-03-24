-b  :Batch-mode operation
	Starts top in 'Batch' mode, which could be useful for sending output from top to other programs or to a file.  In this mode, top will not accept input and runs until the iterations limit you've set  with  the

-d  :Delay-time interval as:  -d ss.t (secs.tenths)
	Specifies the delay between screen updates, and overrides the corresponding value in one's personal configuration file or the startup default.  Later this can be changed with the 'd' or 's'  interactive  commands.

-H  :Threads-mode operation
	Instructs top to display individual threads.  Without this command-line option a summation of all threads in each process is shown.  Later this can be changed with the 'H' interactive command.

-n  :Number-of-iterations limit as:  -n number
	Specifies the maximum number of iterations, or frames, top should produce before ending.

-p  :Monitor-PIDs mode as:  -pN1 -pN2 ...  or  -pN1,N2,N3 ...
	Monitor only processes with specified process IDs.  This option can be given up to 20 times, or you can provide a comma delimited list with up to 20 pids.  Co-mingling both approaches is permitted.
A pid value of zero will be treated as the process id of the top program itself once it is running.
This is a command-line option only and should you wish to return to normal operation, it is not necessary to quit and restart top  --  just issue any of these interactive commands: '=', 'u' or 'U'.
The 'p', 'u' and 'U' command-line options are mutually exclusive.

-u | -U  :User-filter-mode as:  -u | -U number or name
	Display only processes with a user id or user name matching that given.  The '-u' option matches on  effective user whereas the '-U' option matches on any user (real, effective, saved, or filesystem).
Prepending an exclamation point ('!') to the user id or name instructs top to display only processes with users not matching the one provided.
The 'p', 'u' and 'U' command-line options are mutually exclusive.

-w  :Output-width-override as:  -w [ number ]
	In  'Batch'  mode,  when used without an argument top will format output using the COLUMNS= and LINES= environment variables, if set.  Otherwise, width will be fixed at the maximum 512 columns.  With an argument, output width can be decreased or increased (up to 512) but the number of rows is considered unlimited.
In normal display mode, when used without an argument top will attempt to format output using the COLUMNS= and LINES= environment variables, if set.  With an argument, output width can only be decreased,  not increased.  Whether using environment variables or an argument with -w, when not in 'Batch' mode actual terminal dimensions can never be exceeded.
Note: Without the use of this command-line option, output width is always based on the terminal at which top was invoked whether or not in 'Batch' mode.



Up,PgUp  :Scroll-Tasks
	Move the view up toward the first task row, until the first task is displayed at the top of the ´current´ window.  The Up arrow key moves a single line while PgUp scrolls the entire window.

Down,PgDn  :Scroll-Tasks
	Move the view down toward the last task row, until the last task is the only task displayed at the top of the ´current´ window.  The Down arrow key moves a single line while PgDn scrolls the entire window.

Left,Right  :Scroll-Columns
	Move the view of displayable fields horizontally one column at a time.

Note: As a reminder, some fields/columns are not fixed-width but allocated all remaining screen width when visible.  When scrolling right or left, that feature may produce some unexpected results initially.

Additionally,  there are special provisions for any variable width field when positioned as the last displayed field.  Once that field is reached via the right arrow key, and is thus the only column shown, you
can continue scrolling horizontally within such a field.  See the 'C' interactive command below for additional information.

Home  :Jump-to-Home-Position
	Reposition the display to the un-scrolled coordinates.

End  :Jump-to-End-Position
	Reposition the display so that the rightmost column reflects the last displayable field and the bottom task row represents the last task.

Note: From this position it is still possible to scroll down and right using the arrow keys.  This is true until a single column and a single task is left as the only display element.

<  :Move-Sort-Field-Left
	Moves the sort column to the left unless the current sort field is the first field being displayed.

>  :Move-Sort-Field-Right
	Moves the sort column to the right unless the current sort field is the last field being displayed.



k        Kill a task
r        Renice a task
d or s   Change delay/sleep interval
f | F  :Fields-Management
	These keys display a separate screen where you can change which field is used as the sort column, among other functions.  This can be a convenient way to simply verify the current sort field,  when  running top with column highlighting turned Off.

R  :Reverse/Normal-Sort-Field toggle
	Using this interactive command you can alternate between high-to-low and low-to-high sorts.

u | U  :Show-Specific-User-Only
	You will be prompted for the uid or name of the user to display.  The '-u' option matches on  effective user whereas the '-U' option matches on any user (real, effective, saved, or filesystem).
Thereafter,  in  that  task window only matching users will be shown, or possibly no processes will be shown.  Prepending an exclamation point ('!') to the user id or name instructs top to display only processes with users not matching the one provided.
Different task windows can be used to filter different users.  Later, if you wish to monitor all users again in the ´current´ window, re-issue this command but just press <Enter> at the prompt.

n | #  :Set-Maximum-Tasks
	You will be prompted to enter the number of tasks to display.  The lessor of your number and available screen rows will be used.
When used in alternate-display mode, this is the command that gives you precise control over the size of each currently visible task display, except for the very last.  It will not affect the last  window's size, as all prior task displays will have already been painted.
Note: If you wish to increase the size of the last visible task display when in alternate-display mode, simply decrease the size of the task display(s) above it.

c  :Command-Line/Program-Name toggle
	This command will be honored whether or not the 'COMMAND' column is currently visible.  Later, should that field come into view, the change you applied will be seen.


APPEARANCE of task window
J  :Justify-Numeric-Columns toggle
	Alternates between right-justified (the default) and left-justified numeric data.  If the numeric data completely fills the available column, this command toggle may impact the column header only.

j  :Justify-Character-Columns toggle
	Alternates between left-justified (the default) and right-justified character data.  If the character data completely fills the available column, this command toggle may impact the column header only.
The following commands will also be influenced by the state of the global 'B' (bold enable) toggle.

b  :Bold/Reverse toggle
	This command will impact how the 'x' and 'y' toggles are displayed.  Further, it will only be available when at least one of those toggles is On.

x  :Column-Highlight toggle
	Changes highlighting for the current sort field.  If you forget which field is being sorted this command can serve as a quick visual reminder, providing the sort field is being displayed.   The  sort  field might not be visible because:
1) there is insufficient Screen Width
2) the 'f' interactive command turned it Off

Note: Whenever 'Searching' and/or 'Other Filtering' is active in a window, column highlighting is temporarily disabled.  See the notes at the end of topics 5d. SEARCHING and 5e. FILTERING for an explanation why.

y  :Row-Highlight toggle
	Changes highlighting for "running" tasks.  For additional insight into this task state, see topic 3a. DESCRIPTIONS of Fields, the 'S' field (Process Status).Use of this provision provides important insight into your system's health.  The only costs will be a few additional tty escape sequences.

z  :Color/Monochrome toggle
	Switches the ´current´ window between your last used color scheme and the older form of black-on-white or white-on-black.  This command will alter both the summary area and task area but does not affect the state of the 'x', 'y' or 'b' toggles.

L  :Locate-a-string
	You will be prompted for the case-sensitive string to locate starting from the current window coordinates.  There are no restrictions on search string content.
Searches are not limited to values from a single field or column.  All of the values displayed in a task row are allowed in a search string.  You may include spaces, numbers, symbols and even forest view  artwork.
Keying <Enter> with no input will effectively disable the '&' key until a new search string is entered.

&  :Locate-next
	Assuming a search string has been established, top will attempt to locate the next occurrence.
When  a  match  is found, the current window is repositioned vertically so the task row containing that string is first.  The scroll coordinates message can provide confirmation of such vertical repositioning (see the 'C' interactive command).  Horizontal scrolling, however, is never altered via searching.
The availability of a matching string will be influenced by the following factors.
          a. Which fields are displayable from the total available,
             see topic 3b. MANAGING Fields.
          b. Scrolling a window vertically and/or horizontally,
             see topic 5c. SCROLLING a Window.
          c. The state of the command/command-line toggle,
             see the 'c' interactive command.
          d. The stability of the chosen sort column,
             for example PID is good but %CPU bad.
If a search fails, restoring the ´current´ window home (unscrolled) position, scrolling horizontally, displaying command-lines or choosing a more stable sort field could yet produce a successful '&' search.





