[joey](../../../)/
[code](../../)/
[moreutils](../)/

discussion

* [Edit](/ikiwiki.cgi?do=edit&page=code%2Fmoreutils%2Fdiscussion)
* [RecentChanges](../../../recentchanges/)
* [History](http://source.joeyh.branchable.com/?p=source.git;a=history;f=code/moreutils/discussion.mdwn;hb=HEAD)
* [Preferences](/ikiwiki.cgi?do=prefs)
* [Branchable](/ikiwiki.cgi?do=branchable)

Feel free to edit this page to suggest tools to add, or make any other
comments --[Joey](../../../joey/)

## vidir documentation addition: $TMPDIR

I noticed vidir uses `File::Spec->tmpdir` which in turn respects `TMPDIR`. You might want to mention this variable alongside `EDITOR` and `VISUAL` in the `ENVIRONMENT VARIABLES` section of the man page, as it's pretty useful. On a multi-user system, for example, you can set `TMPDIR` to `/run/user/$UID` to avoid the security implications of a globally accessible `/tmp`.

## Sponge segmentation fault

Sponge gets terminated with SIGSEGV if it tries to append to an unwritable file:

(make sure you dont have a file named "a")

```
sudo touch a && sudo chown 000 a && echo 1 | sponge -a a
sudo rm -f a
```

Arch Linux, moreutils 0.63-1

## tool suggestion: "re" (Reach Recent Folders)

The `re` command aims to save numerous `cd` operations for reaching recently-used folders.
This command orders folders by date of last modification, and enables specifying a substring
of the name of the folder targeted. The `re` command saves me a lot of time, every single day.

It is currently implemented as a shell script.
https://github.com/charguer/re

## tool suggestion: "even" and "wol"

Written these two tiny tools, but figure they're useful to others:

*even* was originally written to filter unicode files for use with grep/rg: https://gist.github.com/lionello/9166502

*wol* is a portable wake-on-lan tool: https://gist.github.com/lionello/6481448

## tool suggestion: "fork after grep"

I've written this tool for tzap (tuning DVB-T cards). Iit runs a process as a child, waits for a string to appear on its stdout/stderr, then daemonizes it.
This is useful if a program takes a while to initialize, then prints a message on stdout, but does not daemonize itself.

It put it up on [github here](https://github.com/girst/forkaftergrep)

## chronic

### discarding certain non-zero exit codes

I'm running "chronic fetchmail" in my crontab and I'd like to discard exit code 1 - "no new mail".
The method proposed in fetchmail's man page is to run "chronic sh -c 'fetchmail || [ $? -eq 1 ]'" but I'd prefer something like "chronic -i 1 fetchmail", because this avoids the separate shell and allows to discard several exit codes (think of rsync's various possibly unimportant errors).
I'll try to come up with a patch if this is desired.

-- deep42thought

### triggering with zero exit code

I've a use case where I want chronic to work in exactly the opposite fashion: to throw away stdout/stderr if and only if the exit code is non-zero. I could obviously do this with a wrapper script that inverts the exit code, but that (a) means I only know whether the command I ran had a zero/non-zero exit code, not what it was, and (b) means there's an unnecessary layer between chronic and the command.

I've a patch that achieves exactly this; what's the best way to send it in for you to look at?

-- Adam

### triggering by non-empty stderr output

chronic is now triggered by program returning nonzero exit code. however it's quite often that i encounter scripts that don't return error exit code, but they still output errors on stderr.

I'd like to have chronic to be able to setup in way that would trigger output by nonzero output to stderr.

I suggest parameter -e to do this. (e stands for error)

Like:

```
chronic bash -c 'ls /nonexistent_file; echo hello; exit 0' #no output
chronic -e bash -c 'ls /nonexistent_file; echo hello; exit 0' #output
```

You may say that i could simply do

```
bash -c 'ls /nonexistent_file; echo hello; exit 0' > /dev/null
```

to achieve the same, but it's not the case as it does throw the stdout away. i'd like to see nothing if there's no stderr and exit code 0. if there's non-zero exit code or stderr then i want to see both. stdout and stderr.

I am not sure, but this probably should not trigger if stderr contains only whitespace characters. It should need at least one printable.

Also maybe you can just make this default and use -e to disable it and do the legacy behavior, it's up to you.

I'd would really appreciate this feature. I am trying to write my scripts to return proper code, however i often use 3rd party scripts without proper exit codes and i can't or don't want to change them. Such scripts usualy output lots of stdout when everything is OK, but only way to tell that something went wrong is when they output something to stderr. That would be my usecase.

-- Tomas Mudrunka

> I'd proabably be willing to merge a patch adding -e, but making it the
> default would break existing uses of chronic.
>
> I don't like the filtering out whitespace idea.
>
> I'm somewhat dubious about the idea that scripts so badly written they
> don't exit nonzero on error are somehow practicing good hygene in their
> output to stderr. --[Joey](../../../joey/)
>
> > In fact such scripts do not usually output to stderr themselves. But they may just call some (well written) binararies that output to stderr or exit nonzero. However the script itself exits zero after such fail, because it didn't expected binary to fail and it's not handler properly. At least i think this is the case. --Tomas Mudrunka

### verbose mode for distidguishing output streams and return code

Another feature that might be interresting in chronic would be distinguishing between stdout and stderr in output.
I suggest -v as verbose

```
chronic bash -c 'echo foo 1>&2; echo -n bar; echo baz 1>&2; exit 23' #outputs:
foo
barbaz

chronic -v bash -c 'echo foo 1>&2; echo -n bar; echo baz 1>&2; exit 23' #outputs:
E: foo
O: bar
E: baz
R: 23
```

Also note it adds newline to output when output stream changes in middle of line. Just to make sure that "E: " or "O: " is at the beginning of line.
E: identifies stderr output, O: identifies standart output and R: identifies return code.

This should also work in combination with proposed -e, like chronic -ve something...

I think this would be usefull as hell for debuging cron scripts. I have currently troubles with such debugging.

-- Tomas Mudrunka

> I think this would be a reasonable default behavior. Patches accepted.
> --[Joey](../../../joey/)
>
> > I just realized that this would be usefull as separate wrapper tool that can be used by chronic. --Tomas Mudrunka

## poptail and peeif

I just finished two utilities that might be general purpose enough for the collection. They're on github here:
<https://github.com/ohspite/evenmoreutils>

Here's the summary:

peeif - Pipe STDIN to any number of commands, but only if the exit status of the previous command was zero. Behavior can also be inverted to "peeuntil".

poptail - Print and remove the last lines (or bytes) from a file. This is done without reading the whole file and without copying. Can be used with parallel to batch process the lines of a file.

--Don (PS-thanks for your work on moreutils and your other projects)

## more exposure for errno

After having moreutils installed for a couple months I just stumbled upon `errno` which I find incredibly useful!
How about giving errno program some more love and just mentioning it on the project landing page among others so ppl know it exists?

Thanks

> Thanks, done --[Joey](../../../joey/)

## dc

You are sick of doing ls | wc -l

Why? It is slow on large directories!

instead consider this:

https://github.com/mutantturkey/dc

```
calvin@ecoli:~/big_folder> time ls file2v1dir/ | wc -l
687560

real    0m7.798s
user    0m7.317s
sys     0m0.700s

calvin@ecoli:~/big_folder> time ~/bin/dc file2v1dir/
687560

real    0m0.138s
user    0m0.057s
sys     0m0.081s
```

> A different name might be preferable as dc is the arbitrary precision, reverse-polish calculator that comes with probably all Linux distros. -- miriam-e

## o

* You work often in a console
* You have sometimes files which you want to view/edit with your preferred (registered) desktop tool
* You don't want to keep in mind / know the name e.g. nautilus, evince, libreoffice, ...
* You don't want to type the cmd more than once e.g. libreoffice file\_a; libreoffice file\_b
* You don't want to type long names for the cmd

Here is o:

```
#!/bin/bash
# This is free software.  You may redistribute copies of it under the terms of
# the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
# There is NO WARRANTY, to the extent permitted by law.

test $# -eq 0 && set -- . # open current folder if no parameter

case "$XDG_CURRENT_DESKTOP" in
  KDE)         cmd="kfmclient exec";;
  GNOME|Unity) cmd="gnome-open";;
  XFCE)        cmd="exo-open";;
  *)           cmd="xdg-open";;
esac

which `echo ${cmd/ */}` >/dev/null || cmd=""

test "$cmd" = "" && which xdg-open   >/dev/null && cmd="xdg-open"
test "$cmd" = "" && which kfmclient  >/dev/null && cmd="kfmclient exec"
test "$cmd" = "" && which gnome-open >/dev/null && cmd="gnome-open"
test "$cmd" = "" && which exo-open   >/dev/null && cmd="exo-open"

for file in "$@"
do
  $cmd "$file"
done
```

Would be nice if some can test it with desktop != Unity. Feedback is welcome.

## myperms

In all the years of administration i had often the problem that something
went wrong due to missing permissions. The solution was always the same:

```
ls -ld /
ls -ld /x
ls -ld /x/y -> /y/z
ls -ld /y
ls -ld /y/z
```

* -> if a symlink is used i had to check other paths, too
* -> sometimes i use md5sum to check if the file differs from 2nd server

As a result i developed a tool which shows the user his rights on the whole
tree using ansi colors and the md5sum if it is a file <= 100 MB.

```
$ myperms /usr/share/recovery-mode
# filetype yourperms uid-/gid-/sticky-bit mtime path [md5sum]
dr-x --- 20120511-0030 /
dr-x --- 20120425-1804 /usr
dr-x --- 20120514-2245 /usr/share
lrwx --- 20120510-2321 /usr/share/recovery-mode
>>> /lib/recovery-mode (absolute)
  ...
  dr-x --- 20120511-0029 /lib
  dr-x --- 20120425-1807 /lib/recovery-mode
<<< /lib/recovery-mode

$ myperms /usr/bin/X
# filetype yourperms uid-/gid-/sticky-bit mtime path [md5sum]
dr-x --- 20120511-0030 /
dr-x --- 20120425-1804 /usr
dr-x --- 20120609-2032 /usr/bin
-r-x ug- 20120322-1859 /usr/bin/X a7ac83a4031da58dab3a88e9dd247f51
```

It needs ruby. Tested & developed under Ubuntu 12.04 with Ruby 1.8.

License GPLv3.

I would be glad if you embed it into moreutils. Please send a note if you are interested.

## C

How about translate moreutils to C? Especially, utils for background work like ts; perl is too fat for it. <http://mellonta.narod.ru/f/ts.c>

## lx

I have some code I wrote a decade ago which lists the 'extensions' in a folder. It's like ls -l (a little bit), but defaults to recursive, and colorized. For every extension type (defined as everything after the last dot, unless it starts with a dot) it lists the count and the the total size. If there's only one of that type then the output is a little different. I'd have to find the code and compile it, but it would be nice to release this in the wild.

## datediff

I'd like to suggest a shell script I wrote long ago to manipulate dates and for which I still don't know any available replacement.

It computes the number of days between two dates and can check whether a date exists or not.

```
$ datediff 2009-09-27 2009-10-27
30
$ datediff 2009-09-27 2008-09-27
-365
$ datediff today
2455102
$ datediff today 0
2009-09-27
$ datediff test 2009-02-31
no
$ datediff test 2009-02-28
yes
$ datediff today -30
2009-08-28
```

> How about "ddiff" (and more nice tools) in dateutils at <http://www.fresse.org/dateutils/> -- miriam\_e

## vidir

I hope this is the right place to make any propositions.
Vidir is the, by far, most powerfull mass renaming tool I am aware of, but unfortunately it is limited to terminal use only.
However, sometimes I want to do mass renaming from a graphical file browser, atm this is possible by opening the current folder in terminal and typing vidir.
Many file browsers (e.g. nemo, nautilus, thunar) allow you to specify a command for mass renaming purposes which brings me to the following two limitations:

* In most of these file-browsers the file names are given as URIs which vidir doesn't seem to understand
* My EDITOR variable is, of course, set to vim therefore, it doesn't work from a graphical context.
  It would be nice if vidir would understand a command line flag like --editor where one could set an editor (e.g. gvim) only for the current session

-- Mani

A suggestion regarding vidir:
I would find it quite useful if vidir could work with version control system commands like:

```
svn mv
svn rm
```

or

```
git mv
git rm
```

Another improvement would be the addition would be to add checkboxes to control which files should be controlled by the vcs and which shouldn't.

-- David Riebenbauer

> What I want to do with vidir is make it able to run arbitrary configured
> commands based on filename transformations. So that it can be configured to
> run git add, or svn rm or whatever. Also so that if you remove .gz from a
> filename, it's decompressed; adding .gz compresses it, etc. I have not
> figured out a configuration language that is flexible enough to handle all
> these cases though. --[Joey](../../../joey/)
>
> > What about a Makefile-style stem-based configuration file, like the following?

```
%: %.gz
    gunzip $< -c > $@

%.gz: %
    gzip $< -c > $@
```

> > Plus additional special rules like .ADD .RM .WHATEVER: to specify the commands
> > (although I'm not particularly interested in this, I only use git and tig is an
> > excellent command-line utility to manage the repository). --G. Bilotta

---

How about adding copying ability to vidir?
Items are recognized by the leading number in a line, right? A second instance of the same number should imply copying.

> I tried using `vidir` like that today as I thought it had this feature already, but it doesn’t. Something like `%s/\(.*\)one\(.*\)/&\r\1two\2` (in `vim`) should copy every file containing “one” and replace it with “two” in the copy. That’s not too hard to add as a feature, or is it? -- K. Stephan

---

vidir is great, but when editing and deciding to abandon the sesssion,
deleting the entire buffer should abort (like git commit messages) instead of
deleting all the files. -- N.J. Thomas

> You can undo all your changes (keep 'u' pressed until it goes back to
> the original state: it won't backtrack further). But I agree that a different
> way to do this should be offered. --G. Bilotta

One thing `vidir` needs is a `-i` option (“interactive”) to ask confirmation before action:
it would first present a summary of the request (“the following commands will be issued:
