[joey](../../)/
[code](../)/

moreutils

* [Edit](/ikiwiki.cgi?do=edit&page=code%2Fmoreutils)
* [RecentChanges](../../recentchanges/)
* [History](http://source.joeyh.branchable.com/?p=source.git;a=history;f=code/moreutils.mdwn;hb=HEAD)
* [Preferences](/ikiwiki.cgi?do=prefs)
* [Branchable](/ikiwiki.cgi?do=branchable)
* [Discussion](./discussion/)

moreutils is a collection of the unix tools that nobody thought to
write long ago when unix was young.

It began when I [blogged](../../blog/entry/unix_tools_vidir/):

> I'm a fan of the unix tools philosophy, but I sometimes wonder if there's much
> room for new tools to be added to that toolbox. I've always wanted to come up
> with my own general-purpose new unix tool.

Well, after lots of feedback documented in the many followups
([1](../../blog/entry/unix_tools_followup/) [2](../../blog/entry/moreutils/)
[3](../../blog/entry/moreutils_update/)) in my blog, I've concluded:

> Maybe the problem isn't that no-one is writing them, or that the unix
> toolspace is covered except for specialised tools, but that the most
> basic tools fall through the cracks and are never noticed by people who
> could benefit from them.

And so the moreutils collection was born, to stop these programs from
falling through the cracks.

## What's included

Probably the most general purpose tool in moreutils so far is `sponge`(1),
which lets you do things like this:

```
% sed "s/root/toor/" /etc/passwd | grep -v joey | sponge /etc/passwd
```

There are lots more listed below, and the goal is to collect more,
as long as they're suitably general-purpose,
and don't duplicate other well-known tools.

* chronic: runs a command quietly unless it fails
* combine: combine the lines in two files using boolean operations
* errno: look up errno names and descriptions
* ifdata: get network interface info without parsing ifconfig output
* ifne: run a program if the standard input is not empty
* isutf8: check if a file or standard input is utf-8
* lckdo: execute a program with a lock held
* mispipe: pipe two commands, returning the exit status of the first
* parallel: run multiple jobs at once
* pee: tee standard input to pipes
* sponge: soak up standard input and write to a file
* ts: timestamp standard input
* vidir: edit a directory in your text editor
* vipe: insert a text editor into a pipe
* zrun: automatically uncompress arguments to command

## Download

A Debian package as well as the source tarball for moreutils can be
downloaded from
[packages.debian.org](http://packages.debian.org/unstable/utils/moreutils),
or using apt. It's also in Ubuntu, and, I hear in several other Linux
distributions.

The git repository can be cloned from `git://git.joeyh.name/moreutils`

## News

[version 0.70](./news/version_0.70/)

moreutils 0.70 released with [these changes](#code-moreutils-news-version-0.70.default)

* vidir: Improve zero padding to support larger directories,
  and also avoid unncessary padding.
  Thanks, Martin Kühl
* zrun: Add support for zstd compression
  Thanks, Yannick Le Pennec
* ts: Do not accept extra args and always read from stdin (Closes: #[1041291](http://bugs.debian.org/1041291))
  Thanks, Zefram

Posted Monday evening, December 9th, 2024

[version 0.69](./news/version_0.69/)

moreutils 0.69 released with [these changes](#code-moreutils-news-version-0.69.default)

* Makefile: Warn users of pkgx.dev about their poor life choices.

Posted Sunday evening, February 25th, 2024

[version 0.68](./news/version_0.68/)

moreutils 0.68 released with [these changes](#code-moreutils-news-version-0.68.default)

* popen: Use pclose, fixing compile warning.
  Thanks, Mikel Olasagasti Uranga
* vidir: Zero pad line numbers to work better when used with
  a small tab size such as 2.
  Thanks, Johan Grande

Posted Tuesday evening, November 28th, 2023

## TODO

* pee should support non-blocking i/o to write to the pipes to allow
  concurrent processing of the data by the programs. Alternatively, switch
  to fountain
  <http://hea-www.cfa.harvard.edu/~dj/tmp/fountain-1.0.2.tar.gz>.

  Alternatively, make sponge buffer to stdout if no file is given, and use it
  to buffer the data from pee. Although this will be less efficient and
  will not work as well for very large streams unless sponge avoids
  buffering the whole contents in memory in this case.

## Tools under consideration

This collection is closed at this time for suggestions of
additional tools to add to it. If you would like to take up editorial
responsibility for adding tools, as well as take over maintenance of
moreutils, please contact me.

Here are some that have been suggested but not yet been included:

* dirempty/exists

  It's too hard to tell if a directory is empty in shell.
  Also, while test -e works ok for a single file, it fails if you want to
  see if a wildcard matches anything.

  Suggested in [bug #385069](http://bugs.debian.org/385069), see bug for my
  comments.
* cattail

  Allows catting a file that's still changing (ie, being downloaded)
  to a program. The new bits of the file will continue to be fed to the
  program until the download is done.

  Submitted by Justin Azoff, with code. However, it has to use heuristics
  to guess when the download (or whatever) is done. The current heuristic,
  10 seconds w/o growth, wouldn't work very well for me on dialup.

  Using inotify is probably the best approach.
  [fsniper](http://files.minuslab.net/doc.html) is a less general-purpose
  tool that uses inotify to detect when a file is closed.
* phoenix

  Respawns a process unless a user really wants to quit. Suggested
  in [bug #382428](http://bugs.debian.org/382428)

  Doesn't seem general enough.
* haschanged

  Run it once to store a file's hash, and the second time it'll check
  whether the file has changed.
  <https://blog.steve.fi/the_traffic_is_waiting_outside.html>
* tmp

  puts stdin into a temp file and passes it to the specified program

  ex: zcat file.bmp.gz | tmp zxgv

  Alternative: [pip](http://membled.com/work/apps/pip)
* connect

  connect 'cmd1' op 'cmd2' ... -- connects fd's of commands together, etc

  + In the same spirit as 'pee', but much more powerful.
  + If done very simply, this is handy for writing coprocesses as pipelines
    that need to communicate back and forth.
  + You can do SOME of this with a great shell, like bash or zsh; you can do
    almost all the rest with a bunch of mkfifo commands plus simple
    redirection, but with added complexity and a lot of manual steps.
  + This command could be even more powerful if you gave it
    essentially a "netlist" of fd's to connect. I'm sure the command line
    syntax could be improved, but you get the idea. Very very complex
    example just to illustrate:
    connect 'cmd1' '<> #0:3>4' 'cmd2' '3>' \
    'cmd3' '3<>3 #0:0>' 'cmd4' '3>#1:5'

    ```
    * specs specify connections between adjacent cmds
    * qualified specs (w/ '#') allow more complex connections
    * Some sane defaults, but can be overridden
      * stdin goes to first process that doesn't redirect it
      * stdout comes from everyone that doesn't redirect it
      * stderr comes from everyone that doesn't redirect it
    * cmd1's stdout -> cmd2's stdin
    * cmd2's stdout -> cmd1's stdin
    * fd3           -> cmd2's fd4
    * cmd2's fd3    -> cmd3's stdin
    * cmd3's fd3    -> cmd4's fd3
    * cmd4's fd3    -> cmd3's fd3
    * stdin         -> cmd4
    * cmd4's fd3    -> cmd1's fd5
    * stdout <- all w/o redirected stdout (in this case, cmd3)
    * stderr <- all w/o redirected stderr (in this case, all)
    ```
  + If you think this is a good idea, let me know. I have a basic connect
    command, but it only does two commands. However, I'll be happy to code
    this up if there is interest. (In fact, I think I may anyway, so I don't
    keep doing stuff like this ad-hoc all the time). -- from Wesley J. Landaker
  + Should be possible to roll mispipe up into this by adding a way to flag
    which command(s) exit status to return.

## Rejected tools

(Some of these rejections may be reconsidered later.)

* add

  adds up numbers from stdin

  Already available in [numutils](https://suso.suso.org/programs/num-utils/index.phtml).
  RFP bug filed.
* todist

  inputs a list of numbers and outputs their distribution, a value
  and how many time it occurs in the input
  <http://baruch.ev-en.org/files/todist>

  More suitable for [numutils](https://suso.suso.org/programs/num-utils/index.phtml),
  which can probably do it already. RFP bug filed.
* tostats

  inputs a list of numbers and outputs some statistics about the
  numbers: average, stddev, min, max, mid point
  <http://baruch.ev-en.org/files/tostats>

  More suitable for [numutils](https://suso.suso.org/programs/num-utils/index.phtml),
  which can probably do it already. RFP bug filed.
* unsort

  Randomise the lines of a file. Perfect candidate, but bogosort and rl
  (from the randomize-lines package) already do it.

  <http://savannah.nongnu.org/projects/shuffle/> is a similar thing,
  which its author describes as "almost coreutil ready, but its memory
  bound, a big nono". (Apparently coreutils 6 has a `shuf` and `sort
  --random-sort`.)
* `mime`

  determines the mime type of a file using the gnome mine database

  The File::MimeInfo perl module has a `mimetype` that works like this, and
  uses the freedesktop.org mime database, same as GNOME.

  `file -bi` can do this too.
* srename

  Applies a sed pattern to a list of files to rename them. Rejected because
  perl has a `rename` program that works nearly identically.

Links:
[bin](../bin/)
[blog/entry/Flattr FOSS](../../blog/entry/Flattr_FOSS/)
[blog/entry/Flattr stats](../../blog/entry/Flattr_stats/)
[blog/entry/Volunteer Responsibility Amnesty Day](../../blog/entry/Volunteer_Responsibility_Amnesty_Day/)
[blog/entry/command composition](../../blog/entry/command_composition/)
[blog/entry/file set split utility](../../blog/entry/file_set_split_utility/)
[blog/entry/local rsync accelerator](../../blog/entry/local_rsync_accelerator/)
[blog/entry/moreutils article](../../blog/entry/moreutils_article/)
[blog/entry/moreutils musings](../../blog/entry/moreutils_musings/)
[blog/entry/package news feeds](../../blog/entry/package_news_feeds/)
[blog/entry/twenty years of free software -- part 6 moreutils](../../blog/entry/twenty_years_of_free_software_--_part_6_moreutils/)
[blog/entry/unix tools vidir](../../blog/entry/unix_tools_vidir/)
[code](../)

Last edited at teatime on Saturday, April 16th, 2022