# myhelp
Bash script to help take notes about the system and its commands.

This script creates, edits, and lists user-create help files. Have
you ever referenced the man page one too many times for the same
question? Do you want an easy way to take notes on whatever you want
directly at your command line? Then myhelp.sh might be for you!

By default, the script attempts to create ~/.help, and fails if
it cannot. Customize the directory in the #Config section of the
script.

If the script is called with no arguments, it will print the usage
message and list all available help files, if any.

If the script is called with a file as an arguemnt, it will either
create a new file under ${helpdir}/ with that argument's name, or
edit an existing file under ${helpdir}/ with that argument's name.

The script also accepts a few arguments, visible in the usage msg.
