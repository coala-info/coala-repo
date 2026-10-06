# coreutils CWL Generation Report

## Metadata
- **Skill**: generated

## coreutils_ls

### Tool Description
List information about the FILEs (the current directory by default). Sort entries alphabetically if none of -cftuvSUX nor --sort is specified.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/ls [OPTION]... [FILE]...
List information about the FILEs (the current directory by default).
Sort entries alphabetically if none of -cftuvSUX nor --sort is specified.

Mandatory arguments to long options are mandatory for short options too.
  -a, --all                  do not ignore entries starting with .
  -A, --almost-all           do not list implied . and ..
      --author               with -l, print the author of each file
  -b, --escape               print C-style escapes for nongraphic characters
      --block-size=SIZE      with -l, scale sizes by SIZE when printing them;
                             e.g., '--block-size=M'; see SIZE format below

  -B, --ignore-backups       do not list implied entries ending with ~
  -c                         with -lt: sort by, and show, ctime (time of last
                             change of file status information);
                             with -l: show ctime and sort by name;
                             otherwise: sort by ctime, newest first

  -C                         list entries by columns
      --color[=WHEN]         color the output WHEN; more info below
  -d, --directory            list directories themselves, not their contents
  -D, --dired                generate output designed for Emacs' dired mode
  -f                         do not sort, enable -aU, disable -ls --color
  -F, --classify[=WHEN]      append indicator (one of */=>@|) to entries WHEN
      --file-type            likewise, except do not append '*'
      --format=WORD          across -x, commas -m, horizontal -x, long -l,
                             single-column -1, verbose -l, vertical -C

      --full-time            like -l --time-style=full-iso
  -g                         like -l, but do not list owner
      --group-directories-first
                             group directories before files;
                             can be augmented with a --sort option, but any
                             use of --sort=none (-U) disables grouping

  -G, --no-group             in a long listing, don't print group names
  -h, --human-readable       with -l and -s, print sizes like 1K 234M 2G etc.
      --si                   likewise, but use powers of 1000 not 1024
  -H, --dereference-command-line
                             follow symbolic links listed on the command line
      --dereference-command-line-symlink-to-dir
                             follow each command line symbolic link
                             that points to a directory

      --hide=PATTERN         do not list implied entries matching shell PATTERN
                             (overridden by -a or -A)

      --hyperlink[=WHEN]     hyperlink file names WHEN
      --indicator-style=WORD
                             append indicator with style WORD to entry names:
                             none (default), slash (-p),
                             file-type (--file-type), classify (-F)

  -i, --inode                print the index number of each file
  -I, --ignore=PATTERN       do not list implied entries matching shell PATTERN
  -k, --kibibytes            default to 1024-byte blocks for file system usage;
                             used only with -s and per directory totals

  -l                         use a long listing format
  -L, --dereference          when showing file information for a symbolic
                             link, show information for the file the link
                             references rather than for the link itself

  -m                         fill width with a comma separated list of entries
  -n, --numeric-uid-gid      like -l, but list numeric user and group IDs
  -N, --literal              print entry names without quoting
  -o                         like -l, but do not list group information
  -p, --indicator-style=slash
                             append / indicator to directories
  -q, --hide-control-chars   print ? instead of nongraphic characters
      --show-control-chars   show nongraphic characters as-is (the default,
                             unless program is 'ls' and output is a terminal)

  -Q, --quote-name           enclose entry names in double quotes
      --quoting-style=WORD   use quoting style WORD for entry names:
                             literal, locale, shell, shell-always,
                             shell-escape, shell-escape-always, c, escape
                             (overrides QUOTING_STYLE environment variable)

  -r, --reverse              reverse order while sorting
  -R, --recursive            list subdirectories recursively
  -s, --size                 print the allocated size of each file, in blocks
  -S                         sort by file size, largest first
      --sort=WORD            sort by WORD instead of name: none (-U), size (-S),
                             time (-t), version (-v), extension (-X), width

      --time=WORD            select which timestamp used to display or sort;
                               access time (-u): atime, access, use;
                               metadata change time (-c): ctime, status;
                               modified time (default): mtime, modification;
                               birth time: birth, creation;
                             with -l, WORD determines which time to show;
                             with --sort=time, sort by WORD (newest first)

      --time-style=TIME_STYLE
                             time/date format with -l; see TIME_STYLE below
  -t                         sort by time, newest first; see --time
  -T, --tabsize=COLS         assume tab stops at each COLS instead of 8
  -u                         with -lt: sort by, and show, access time;
                             with -l: show access time and sort by name;
                             otherwise: sort by access time, newest first

  -U                         do not sort; list entries in directory order
  -v                         natural sort of (version) numbers within text
  -w, --width=COLS           set output width to COLS.  0 means no limit
  -x                         list entries by lines instead of by columns
  -X                         sort alphabetically by entry extension
  -Z, --context              print any security context of each file
      --zero                 end each output line with NUL, not newline
  -1                         list one file per line
      --help        display this help and exit
      --version     output version information and exit

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y,R,Q (powers of 1024) or KB,MB,... (powers of 1000).
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

The TIME_STYLE argument can be full-iso, long-iso, iso, locale, or +FORMAT.
FORMAT is interpreted like in date(1).  If FORMAT is FORMAT1<newline>FORMAT2,
then FORMAT1 applies to non-recent files and FORMAT2 to recent files.
TIME_STYLE prefixed with 'posix-' takes effect only outside the POSIX locale.
Also the TIME_STYLE environment variable sets the default style to use.

The WHEN argument defaults to 'always' and can also be 'auto' or 'never'.

Using color to distinguish file types is disabled both by default and
with --color=never.  With --color=auto, ls emits color codes only when
standard output is connected to a terminal.  The LS_COLORS environment
variable can change the settings.  Use the dircolors(1) command to set it.

Exit status:
 0  if OK,
 1  if minor problems (e.g., cannot access subdirectory),
 2  if serious trouble (e.g., cannot access command-line argument).

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/ls>
or available locally via: info '(coreutils) ls invocation'
```
## coreutils_cp

### Tool Description
Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/cp [OPTION]... [-T] SOURCE DEST
  or:  /usr/local/bin/cp [OPTION]... SOURCE... DIRECTORY
  or:  /usr/local/bin/cp [OPTION]... -t DIRECTORY SOURCE...
Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY.

Mandatory arguments to long options are mandatory for short options too.
  -a, --archive                same as -dR --preserve=all
      --attributes-only        don't copy the file data, just the attributes
      --backup[=CONTROL]       make a backup of each existing destination file
  -b                           like --backup but does not accept an argument
      --copy-contents          copy contents of special files when recursive
  -d                           same as --no-dereference --preserve=links
      --debug                  explain how a file is copied.  Implies -v
  -f, --force                  if an existing destination file cannot be
                                 opened, remove it and try again (this option
                                 is ignored when the -n option is also used)
  -i, --interactive            prompt before overwrite (overrides a previous -n
                                  option)
  -H                           follow command-line symbolic links in SOURCE
  -l, --link                   hard link files instead of copying
  -L, --dereference            always follow symbolic links in SOURCE
  -n, --no-clobber             (deprecated) silently skip existing files.
                                 See also --update
  -P, --no-dereference         never follow symbolic links in SOURCE
  -p                           same as --preserve=mode,ownership,timestamps
      --preserve[=ATTR_LIST]   preserve the specified attributes
      --no-preserve=ATTR_LIST  don't preserve the specified attributes
      --parents                use full source file name under DIRECTORY
  -R, -r, --recursive          copy directories recursively
      --reflink[=WHEN]         control clone/CoW copies. See below
      --remove-destination     remove each existing destination file before
                                 attempting to open it (contrast with --force)
      --sparse=WHEN            control creation of sparse files. See below
      --strip-trailing-slashes  remove any trailing slashes from each SOURCE
                                 argument
  -s, --symbolic-link          make symbolic links instead of copying
  -S, --suffix=SUFFIX          override the usual backup suffix
  -t, --target-directory=DIRECTORY  copy all SOURCE arguments into DIRECTORY
  -T, --no-target-directory    treat DEST as a normal file
  --update[=UPDATE]            control which existing files are updated;
                                 UPDATE={all,none,none-fail,older(default)}.
  -u                           equivalent to --update[=older].  See below
  -v, --verbose                explain what is being done
      --keep-directory-symlink  follow existing symlinks to directories
  -x, --one-file-system        stay on this file system
  -Z                           set SELinux security context of destination
                                 file to default type
      --context[=CTX]          like -Z, or if CTX is specified then set the
                                 SELinux or SMACK security context to CTX
      --help        display this help and exit
      --version     output version information and exit

ATTR_LIST is a comma-separated list of attributes. Attributes are 'mode' for
permissions (including any ACL and xattr permissions), 'ownership' for user
and group, 'timestamps' for file timestamps, 'links' for hard links, 'context'
for security context, 'xattr' for extended attributes, and 'all' for all
attributes.

By default, sparse SOURCE files are detected by a crude heuristic and the
corresponding DEST file is made sparse as well.  That is the behavior
selected by --sparse=auto.  Specify --sparse=always to create a sparse DEST
file whenever the SOURCE file contains a long enough sequence of zero bytes.
Use --sparse=never to inhibit creation of sparse files.

UPDATE controls which existing files in the destination are replaced.
'all' is the default operation when an --update option is not specified,
and results in all existing files in the destination being replaced.
'none' is like the --no-clobber option, in that no files in the
destination are replaced, and skipped files do not induce a failure.
'none-fail' also ensures no files are replaced in the destination,
but any skipped files are diagnosed and induce a failure.
'older' is the default operation when --update is specified, and results
in files being replaced if they're older than the corresponding source file.

When --reflink[=always] is specified, perform a lightweight copy, where the
data blocks are copied only when modified.  If this is not possible the copy
fails, or if --reflink=auto is specified, fall back to a standard copy.
Use --reflink=never to ensure a standard copy is performed.

The backup suffix is '~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.
The version control method may be selected via the --backup option or through
the VERSION_CONTROL environment variable.  Here are the values:

  none, off       never make backups (even if --backup is given)
  numbered, t     make numbered backups
  existing, nil   numbered if numbered backups exist, simple otherwise
  simple, never   always make simple backups

As a special case, cp makes a backup of SOURCE when the force and backup
options are given and SOURCE and DEST are the same name for an existing,
regular file.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/cp>
or available locally via: info '(coreutils) cp invocation'
```

## coreutils_mv

### Tool Description
Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/mv [OPTION]... [-T] SOURCE DEST
  or:  /usr/local/bin/mv [OPTION]... SOURCE... DIRECTORY
  or:  /usr/local/bin/mv [OPTION]... -t DIRECTORY SOURCE...
Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.

Mandatory arguments to long options are mandatory for short options too.
      --backup[=CONTROL]       make a backup of each existing destination file
  -b                           like --backup but does not accept an argument
      --debug                  explain how a file is copied.  Implies -v
      --exchange               exchange source and destination
  -f, --force                  do not prompt before overwriting
  -i, --interactive            prompt before overwrite
  -n, --no-clobber             do not overwrite an existing file
If you specify more than one of -i, -f, -n, only the final one takes effect.
      --no-copy                do not copy if renaming fails
      --strip-trailing-slashes  remove any trailing slashes from each SOURCE
                                 argument
  -S, --suffix=SUFFIX          override the usual backup suffix
  -t, --target-directory=DIRECTORY  move all SOURCE arguments into DIRECTORY
  -T, --no-target-directory    treat DEST as a normal file
  --update[=UPDATE]            control which existing files are updated;
                                 UPDATE={all,none,none-fail,older(default)}.
  -u                           equivalent to --update[=older].  See below
  -v, --verbose                explain what is being done
  -Z, --context                set SELinux security context of destination
                                 file to default type
      --help        display this help and exit
      --version     output version information and exit

UPDATE controls which existing files in the destination are replaced.
'all' is the default operation when an --update option is not specified,
and results in all existing files in the destination being replaced.
'none' is like the --no-clobber option, in that no files in the
destination are replaced, and skipped files do not induce a failure.
'none-fail' also ensures no files are replaced in the destination,
but any skipped files are diagnosed and induce a failure.
'older' is the default operation when --update is specified, and results
in files being replaced if they're older than the corresponding source file.

The backup suffix is '~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.
The version control method may be selected via the --backup option or through
the VERSION_CONTROL environment variable.  Here are the values:

  none, off       never make backups (even if --backup is given)
  numbered, t     make numbered backups
  existing, nil   numbered if numbered backups exist, simple otherwise
  simple, never   always make simple backups

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/mv>
or available locally via: info '(coreutils) mv invocation'
```

## coreutils_rm

### Tool Description
Remove (unlink) the FILE(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/rm [OPTION]... [FILE]...
Remove (unlink) the FILE(s).

  -f, --force           ignore nonexistent files and arguments, never prompt
  -i                    prompt before every removal
  -I                    prompt once before removing more than three files, or
                          when removing recursively; less intrusive than -i,
                          while still giving protection against most mistakes
      --interactive[=WHEN]  prompt according to WHEN: never, once (-I), or
                          always (-i); without WHEN, prompt always
      --one-file-system  when removing a hierarchy recursively, skip any
                          directory that is on a file system different from
                          that of the corresponding command line argument
      --no-preserve-root  do not treat '/' specially
      --preserve-root[=all]  do not remove '/' (default);
                              with 'all', reject any command line argument
                              on a separate device from its parent
  -r, -R, --recursive   remove directories and their contents recursively
  -d, --dir             remove empty directories
  -v, --verbose         explain what is being done
      --help        display this help and exit
      --version     output version information and exit

By default, rm does not remove directories.  Use the --recursive (-r or -R)
option to remove each listed directory, too, along with all of its contents.

Any attempt to remove a file whose last file name component is '.' or '..'
is rejected with a diagnostic.

To remove a file whose name starts with a '-', for example '-foo',
use one of these commands:
  /usr/local/bin/rm -- -foo

  /usr/local/bin/rm ./-foo

If you use rm to remove a file, it might be possible to recover
some of its contents, given sufficient expertise and/or time.  For greater
assurance that the contents are unrecoverable, consider using shred(1).

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/rm>
or available locally via: info '(coreutils) rm invocation'
```

## coreutils_chmod

### Tool Description
Change the mode of each FILE to MODE. With --reference, change the mode of each FILE to that of RFILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/chmod [OPTION]... MODE[,MODE]... FILE...
  or:  /usr/local/bin/chmod [OPTION]... OCTAL-MODE FILE...
  or:  /usr/local/bin/chmod [OPTION]... --reference=RFILE FILE...
Change the mode of each FILE to MODE.
With --reference, change the mode of each FILE to that of RFILE.

  -c, --changes          like verbose but report only when a change is made
  -f, --silent, --quiet  suppress most error messages
  -v, --verbose          output a diagnostic for every file processed
      --dereference      affect the referent of each symbolic link,
                           rather than the symbolic link itself
  -h, --no-dereference   affect each symbolic link, rather than the referent
      --no-preserve-root  do not treat '/' specially (the default)
      --preserve-root    fail to operate recursively on '/'
      --reference=RFILE  use RFILE's mode instead of specifying MODE values.
                         RFILE is always dereferenced if a symbolic link.
  -R, --recursive        change files and directories recursively

The following options modify how a hierarchy is traversed when the -R
option is also specified.  If more than one is specified, only the final
one takes effect. '-H' is the default.

  -H                     if a command line argument is a symbolic link
                         to a directory, traverse it
  -L                     traverse every symbolic link to a directory
                         encountered
  -P                     do not traverse any symbolic links

      --help        display this help and exit
      --version     output version information and exit

Each MODE is of the form '[ugoa]*([-+=]([rwxXst]*|[ugo]))+|[-+=][0-7]+'.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/chmod>
or available locally via: info '(coreutils) chmod invocation'
```

## coreutils_chown

### Tool Description
Change the owner and/or group of each FILE to OWNER and/or GROUP. With --reference, change the owner and group of each FILE to those of RFILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/chown [OPTION]... [OWNER][:[GROUP]] FILE...
  or:  /usr/local/bin/chown [OPTION]... --reference=RFILE FILE...
Change the owner and/or group of each FILE to OWNER and/or GROUP.
With --reference, change the owner and group of each FILE to those of RFILE.

  -c, --changes          like verbose but report only when a change is made
  -f, --silent, --quiet  suppress most error messages
  -v, --verbose          output a diagnostic for every file processed
      --dereference      affect the referent of each symbolic link (this is
                         the default), rather than the symbolic link itself
  -h, --no-dereference   affect symbolic links instead of any referenced file
                         (useful only on systems that can change the
                         ownership of a symlink)
      --from=CURRENT_OWNER:CURRENT_GROUP
                         change the ownership of each file only if
                         its current owner and/or group match those specified
                         here. Either may be omitted, in which case a match
                         is not required for the omitted attribute
      --no-preserve-root  do not treat '/' specially (the default)
      --preserve-root    fail to operate recursively on '/'
      --reference=RFILE  use RFILE's ownership rather than specifying values
                         RFILE is always dereferenced if a symbolic link.
  -R, --recursive        operate on files and directories recursively

The following options modify how a hierarchy is traversed when the -R
option is also specified.  If more than one is specified, only the final
one takes effect. '-P' is the default.

  -H                     if a command line argument is a symbolic link
                         to a directory, traverse it
  -L                     traverse every symbolic link to a directory
                         encountered
  -P                     do not traverse any symbolic links

      --help        display this help and exit
      --version     output version information and exit

Owner is unchanged if missing.  Group is unchanged if missing, but changed
to login group if implied by a ':' following a symbolic OWNER.
OWNER and GROUP may be numeric as well as symbolic.

Examples:
  /usr/local/bin/chown root /u        Change the owner of /u to "root".
  /usr/local/bin/chown root:staff /u  Likewise, but also change its group to "staff".
  /usr/local/bin/chown -hR root /u    Change the owner of /u and subfiles to "root".

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/chown>
or available locally via: info '(coreutils) chown invocation'
```

## coreutils_cat

### Tool Description
Concatenate FILE(s) to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/cat [OPTION]... [FILE]...
Concatenate FILE(s) to standard output.

With no FILE, or when FILE is -, read standard input.

  -A, --show-all           equivalent to -vET
  -b, --number-nonblank    number nonempty output lines, overrides -n
  -e                       equivalent to -vE
  -E, --show-ends          display $ at end of each line
  -n, --number             number all output lines
  -s, --squeeze-blank      suppress repeated empty output lines
  -t                       equivalent to -vT
  -T, --show-tabs          display TAB characters as ^I
  -u                       (ignored)
  -v, --show-nonprinting   use ^ and M- notation, except for LFD and TAB
      --help        display this help and exit
      --version     output version information and exit

Examples:
  /usr/local/bin/cat f - g  Output f's contents, then standard input, then g's contents.
  /usr/local/bin/cat        Copy standard input to standard output.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/cat>
or available locally via: info '(coreutils) cat invocation'
```
## coreutils_tac

### Tool Description
Write each FILE to standard output, last line first. With no FILE, or when FILE is -, read standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/tac [OPTION]... [FILE]...
Write each FILE to standard output, last line first.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -b, --before             attach the separator before instead of after
  -r, --regex              interpret the separator as a regular expression
  -s, --separator=STRING   use STRING as the separator instead of newline
      --help        display this help and exit
      --version     output version information and exit

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/tac>
or available locally via: info '(coreutils) tac invocation'
```
## coreutils_head

### Tool Description
Print the first 10 lines of each FILE to standard output. With more than one FILE, precede each with a header giving the file name. With no FILE, or when FILE is -, read standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/head [OPTION]... [FILE]...
Print the first 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file name.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -c, --bytes=[-]NUM       print the first NUM bytes of each file;
                             with the leading '-', print all but the last
                             NUM bytes of each file
  -n, --lines=[-]NUM       print the first NUM lines instead of the first 10;
                             with the leading '-', print all but the last
                             NUM lines of each file
  -q, --quiet, --silent    never print headers giving file names
  -v, --verbose            always print headers giving file names
  -z, --zero-terminated    line delimiter is NUL, not newline
      --help        display this help and exit
      --version     output version information and exit

NUM may have a multiplier suffix:
b 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024,
GB 1000*1000*1000, G 1024*1024*1024, and so on for T, P, E, Z, Y, R, Q.
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/head>
or available locally via: info '(coreutils) head invocation'
```

## coreutils_tail

### Tool Description
Print the last 10 lines of each FILE to standard output. With more than one FILE, precede each with a header giving the file name.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/tail [OPTION]... [FILE]...
Print the last 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file name.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -c, --bytes=[+]NUM       output the last NUM bytes; or use -c +NUM to
                             output starting with byte NUM of each file
  -f, --follow[={name|descriptor}]
                           output appended data as the file grows;
                             an absent option argument means 'descriptor'
  -F                       same as --follow=name --retry
  -n, --lines=[+]NUM       output the last NUM lines, instead of the last 10;
                             or use -n +NUM to skip NUM-1 lines at the start
      --max-unchanged-stats=N
                           with --follow=name, reopen a FILE which has not
                             changed size after N (default 5) iterations
                             to see if it has been unlinked or renamed
                             (this is the usual case of rotated log files);
                             with inotify, this option is rarely useful
      --pid=PID            with -f, terminate after process ID, PID dies;
                             can be repeated to watch multiple processes
  -q, --quiet, --silent    never output headers giving file names
      --retry              keep trying to open a file if it is inaccessible
  -s, --sleep-interval=N   with -f, sleep for approximately N seconds
                             (default 1.0) between iterations;
                             with inotify and --pid=P, check process P at
                             least once every N seconds
  -v, --verbose            always output headers giving file names
  -z, --zero-terminated    line delimiter is NUL, not newline
      --help        display this help and exit
      --version     output version information and exit

NUM may have a multiplier suffix:
b 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024,
GB 1000*1000*1000, G 1024*1024*1024, and so on for T, P, E, Z, Y, R, Q.
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

With --follow (-f), tail defaults to following the file descriptor, which
means that even if a tail'ed file is renamed, tail will continue to track
its end.  This default behavior is not desirable when you really want to
track the actual name of the file, not the file descriptor (e.g., log
rotation).  Use --follow=name in that case.  That causes tail to track the
named file in a way that accommodates renaming, removal and creation.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/tail>
or available locally via: info '(coreutils) tail invocation'
```

## coreutils_sort

### Tool Description
Write sorted concatenation of all FILE(s) to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/sort [OPTION]... [FILE]...
  or:  /usr/local/bin/sort [OPTION]... --files0-from=F
Write sorted concatenation of all FILE(s) to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
Ordering options:

  -b, --ignore-leading-blanks  ignore leading blanks
  -d, --dictionary-order      consider only blanks and alphanumeric characters
  -f, --ignore-case           fold lower case to upper case characters
  -g, --general-numeric-sort  compare according to general numerical value
  -i, --ignore-nonprinting    consider only printable characters
  -M, --month-sort            compare (unknown) < 'JAN' < ... < 'DEC'
  -h, --human-numeric-sort    compare human readable numbers (e.g., 2K 1G)
  -n, --numeric-sort          compare according to string numerical value;
                                see manual for which strings are supported
  -R, --random-sort           shuffle, but group identical keys.  See shuf(1)
      --random-source=FILE    get random bytes from FILE
  -r, --reverse               reverse the result of comparisons
      --sort=WORD             sort according to WORD:
                                general-numeric -g, human-numeric -h, month -M,
                                numeric -n, random -R, version -V
  -V, --version-sort          natural sort of (version) numbers within text

Other options:

      --batch-size=NMERGE   merge at most NMERGE inputs at once;
                            for more use temp files
  -c, --check, --check=diagnose-first  check for sorted input; do not sort
  -C, --check=quiet, --check=silent  like -c, but do not report first bad line
      --compress-program=PROG  compress temporaries with PROG;
                              decompress them with PROG -d
      --debug               annotate the part of the line used to sort,
                              and warn about questionable usage to stderr
      --files0-from=F       read input from the files specified by
                            NUL-terminated names in file F;
                            If F is - then read names from standard input
  -k, --key=KEYDEF          sort via a key; KEYDEF gives location and type
  -m, --merge               merge already sorted files; do not sort
  -o, --output=FILE         write result to FILE instead of standard output
  -s, --stable              stabilize sort by disabling last-resort comparison
  -S, --buffer-size=SIZE    use SIZE for main memory buffer
  -t, --field-separator=SEP  use SEP instead of non-blank to blank transition
  -T, --temporary-directory=DIR  use DIR for temporaries, not $TMPDIR or /tmp;
                              multiple options specify multiple directories
      --parallel=N          change the number of sorts run concurrently to N
  -u, --unique              with -c, check for strict ordering;
                              without -c, output only the first of an equal run
  -z, --zero-terminated     line delimiter is NUL, not newline
      --help        display this help and exit
      --version     output version information and exit

KEYDEF is F[.C][OPTS][,F[.C][OPTS]] for start and stop position, where F is a
field number and C a character position in the field; both are origin 1, and
the stop position defaults to the line's end.  If neither -t nor -b is in
effect, characters in a field are counted from the beginning of the preceding
whitespace.  OPTS is one or more single-letter ordering options [bdfgiMhnRrV],
which override global ordering options for that key.  If no key is given, use
the entire line as the key.  Use --debug to diagnose incorrect key usage.

SIZE may be followed by the following multiplicative suffixes:
% 1% of memory, b 1, K 1024 (default), and so on for M, G, T, P, E, Z, Y, R, Q.

*** WARNING ***
The locale specified by the environment affects sort order.
Set LC_ALL=C to get the traditional sort order that uses
native byte values.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/sort>
or available locally via: info '(coreutils) sort invocation'
```

## coreutils_uniq

### Tool Description
Filter adjacent matching lines from INPUT (or standard input), writing to OUTPUT (or standard output).

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/uniq [OPTION]... [INPUT [OUTPUT]]
Filter adjacent matching lines from INPUT (or standard input),
writing to OUTPUT (or standard output).

With no options, matching lines are merged to the first occurrence.

Mandatory arguments to long options are mandatory for short options too.
  -c, --count           prefix lines by the number of occurrences
  -d, --repeated        only print duplicate lines, one for each group
  -D                    print all duplicate lines
      --all-repeated[=METHOD]  like -D, but allow separating groups
                                 with an empty line;
                                 METHOD={none(default),prepend,separate}
  -f, --skip-fields=N   avoid comparing the first N fields
      --group[=METHOD]  show all items, separating groups with an empty line;
                          METHOD={separate(default),prepend,append,both}
  -i, --ignore-case     ignore differences in case when comparing
  -s, --skip-chars=N    avoid comparing the first N characters
  -u, --unique          only print unique lines
  -z, --zero-terminated     line delimiter is NUL, not newline
  -w, --check-chars=N   compare no more than N characters in lines
      --help        display this help and exit
      --version     output version information and exit

A field is a run of blanks (usually spaces and/or TABs), then non-blank
characters.  Fields are skipped before chars.

'uniq' does not detect repeated lines unless they are adjacent.
You may want to sort the input first, or use 'sort -u' without 'uniq'.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/uniq>
or available locally via: info '(coreutils) uniq invocation'
```

## coreutils_cut

### Tool Description
Print selected parts of lines from each FILE to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/cut OPTION... [FILE]...
Print selected parts of lines from each FILE to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -b, --bytes=LIST        select only these bytes
  -c, --characters=LIST   select only these characters
  -d, --delimiter=DELIM   use DELIM instead of TAB for field delimiter
  -f, --fields=LIST       select only these fields;  also print any line
                            that contains no delimiter character, unless
                            the -s option is specified
  -n                      (ignored)
      --complement        complement the set of selected bytes, characters
                            or fields
  -s, --only-delimited    do not print lines not containing delimiters
      --output-delimiter=STRING  use STRING as the output delimiter
                            the default is to use the input delimiter
  -z, --zero-terminated   line delimiter is NUL, not newline
      --help        display this help and exit
      --version     output version information and exit

Use one, and only one of -b, -c or -f.  Each LIST is made up of one
range, or many ranges separated by commas.  Selected input is written
in the same order that it is read, and is written exactly once.
Each range is one of:

  N     N'th byte, character or field, counted from 1
  N-    from N'th byte, character or field, to end of line
  N-M   from N'th to M'th (included) byte, character or field
  -M    from first to M'th (included) byte, character or field

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/cut>
or available locally via: info '(coreutils) cut invocation'
```

## coreutils_df

### Tool Description
Show information about the file system on which each FILE resides, or all file systems by default.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/df [OPTION]... [FILE]...
Show information about the file system on which each FILE resides,
or all file systems by default.

Mandatory arguments to long options are mandatory for short options too.
  -a, --all             include pseudo, duplicate, inaccessible file systems
  -B, --block-size=SIZE  scale sizes by SIZE before printing them; e.g.,
                           '-BM' prints sizes in units of 1,048,576 bytes;
                           see SIZE format below
  -h, --human-readable  print sizes in powers of 1024 (e.g., 1023M)
  -H, --si              print sizes in powers of 1000 (e.g., 1.1G)
  -i, --inodes          list inode information instead of block usage
  -k                    like --block-size=1K
  -l, --local           limit listing to local file systems
      --no-sync         do not invoke sync before getting usage info (default)
      --output[=FIELD_LIST]  use the output format defined by FIELD_LIST,
                               or print all fields if FIELD_LIST is omitted.
  -P, --portability     use the POSIX output format
      --sync            invoke sync before getting usage info
      --total           elide all entries insignificant to available space,
                          and produce a grand total
  -t, --type=TYPE       limit listing to file systems of type TYPE
  -T, --print-type      print file system type
  -x, --exclude-type=TYPE   limit listing to file systems not of type TYPE
  -v                    (ignored)
      --help        display this help and exit
      --version     output version information and exit

Display values are in units of the first available SIZE from --block-size,
and the DF_BLOCK_SIZE, BLOCK_SIZE and BLOCKSIZE environment variables.
Otherwise, units default to 1024 bytes (or 512 if POSIXLY_CORRECT is set).

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y,R,Q (powers of 1024) or KB,MB,... (powers of 1000).
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

FIELD_LIST is a comma-separated list of columns to be included.  Valid
field names are: 'source', 'fstype', 'itotal', 'iused', 'iavail', 'ipcent',
'size', 'used', 'avail', 'pcent', 'file' and 'target' (see info page).

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/df>
or available locally via: info '(coreutils) df invocation'
```

## coreutils_du

### Tool Description
Estimate file space usage

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
[Removed: the command ran instead of printing help, and its output (disk usage of the host working directory) was recorded here. It is not help text and exposed host information.]
```

## coreutils_env

### Tool Description
Set each NAME to VALUE in the environment and run COMMAND.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/env [OPTION]... [-] [NAME=VALUE]... [COMMAND [ARG]...]
Set each NAME to VALUE in the environment and run COMMAND.

Mandatory arguments to long options are mandatory for short options too.
  -a, --argv0=ARG      pass ARG as the zeroth argument of COMMAND
  -i, --ignore-environment  start with an empty environment
  -0, --null           end each output line with NUL, not newline
  -u, --unset=NAME     remove variable from the environment
  -C, --chdir=DIR      change working directory to DIR
  -S, --split-string=S  process and split S into separate arguments;
                        used to pass multiple arguments on shebang lines
      --block-signal[=SIG]    block delivery of SIG signal(s) to COMMAND
      --default-signal[=SIG]  reset handling of SIG signal(s) to the default
      --ignore-signal[=SIG]   set handling of SIG signal(s) to do nothing
      --list-signal-handling  list non default signal handling to stderr
  -v, --debug          print verbose information for each processing step
      --help        display this help and exit
      --version     output version information and exit

A mere - implies -i.  If no COMMAND, print the resulting environment.

SIG may be a signal name like 'PIPE', or a signal number like '13'.
Without SIG, all known signals are included.  Multiple signals can be
comma-separated.  An empty SIG argument is a no-op.

Exit status:
  125  if the env command itself fails
  126  if COMMAND is found but cannot be invoked
  127  if COMMAND cannot be found
  -    the exit status of COMMAND otherwise

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/env>
or available locally via: info '(coreutils) env invocation'
```
## coreutils_uptime

### Tool Description
Print the current time, the length of time the system has been up, the number of users on the system, and the average number of jobs in the run queue over the last 1, 5 and 15 minutes. Processes in an uninterruptible sleep state also contribute to the load average. If FILE is not specified, use /var/run/utmp.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/uptime [OPTION]... [FILE]
Print the current time, the length of time the system has been up,
the number of users on the system, and the average number of jobs
in the run queue over the last 1, 5 and 15 minutes.  Processes in
an uninterruptible sleep state also contribute to the load average.
If FILE is not specified, use /var/run/utmp.  /var/log/wtmp as FILE is common.

      --help        display this help and exit
      --version     output version information and exit

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/uptime>
or available locally via: info '(coreutils) uptime invocation'
```

## coreutils_numfmt

### Tool Description
Reformat NUMBER(s), or the numbers from standard input if none are specified.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/numfmt [OPTION]... [NUMBER]...
Reformat NUMBER(s), or the numbers from standard input if none are specified.

Mandatory arguments to long options are mandatory for short options too.
      --debug          print warnings about invalid input
  -d, --delimiter=X    use X instead of whitespace for field delimiter
      --field=FIELDS   replace the numbers in these input fields (default=1);
                         see FIELDS below
      --format=FORMAT  use printf style floating-point FORMAT;
                         see FORMAT below for details
      --from=UNIT      auto-scale input numbers to UNITs; default is 'none';
                         see UNIT below
      --from-unit=N    specify the input unit size (instead of the default 1)
      --grouping       use locale-defined grouping of digits, e.g. 1,000,000
                         (which means it has no effect in the C/POSIX locale)
      --header[=N]     print (without converting) the first N header lines;
                         N defaults to 1 if not specified
      --invalid=MODE   failure mode for invalid numbers: MODE can be:
                         abort (default), fail, warn, ignore
      --padding=N      pad the output to N characters; positive N will
                         right-align; negative N will left-align;
                         padding is ignored if the output is wider than N;
                         the default is to automatically pad if a whitespace
                         is found
      --round=METHOD   use METHOD for rounding when scaling; METHOD can be:
                         up, down, from-zero (default), towards-zero, nearest
      --suffix=SUFFIX  add SUFFIX to output numbers, and accept optional
                         SUFFIX in input numbers
      --to=UNIT        auto-scale output numbers to UNITs; see UNIT below
      --to-unit=N      the output unit size (instead of the default 1)
  -z, --zero-terminated    line delimiter is NUL, not newline
      --help        display this help and exit
      --version     output version information and exit

UNIT options:
  none       no auto-scaling is done; suffixes will trigger an error
  auto       accept optional single/two letter suffix:
               1K = 1000, 1k = 1000,
               1Ki = 1024,
               1M = 1000000,
               1Mi = 1048576,
  si         accept optional single letter suffix:
               1k = 1000, 1K = 1000,
               1M = 1000000,
               ...
  iec        accept optional single letter suffix:
               1K = 1024, 1k = 1024,
               1M = 1048576,
               ...
  iec-i      accept optional two-letter suffix:
               1Ki = 1024, 1ki = 1024,
               1Mi = 1048576,
               ...

FIELDS supports cut(1) style field ranges:
  N    N'th field, counted from 1
  N-   from N'th field, to end of line
  N-M  from N'th to M'th field (inclusive)
  -M   from first to M'th field (inclusive)
  -    all fields
Multiple fields/ranges can be separated with commas

FORMAT must be suitable for printing one floating-point argument '%f'.
Optional quote (%'f) will enable --grouping (if supported by current locale).
Optional width value (%10f) will pad output. Optional zero (%010f) width
will zero pad the number. Optional negative values (%-10f) will left align.
Optional precision (%.1f) will override the input determined precision.

Exit status is 0 if all input numbers were successfully converted.
By default, /usr/local/bin/numfmt will stop at the first conversion error with exit status 2.
With --invalid='fail' a warning is printed for each conversion error
and the exit status is 2.  With --invalid='warn' each conversion error is
diagnosed, but the exit status is 0.  With --invalid='ignore' conversion
errors are not diagnosed and the exit status is 0.

Examples:
  $ /usr/local/bin/numfmt --to=si 1000
            -> "1.0k"
  $ /usr/local/bin/numfmt --to=iec 2048
           -> "2.0K"
  $ /usr/local/bin/numfmt --to=iec-i 4096
           -> "4.0Ki"
  $ echo 1K | /usr/local/bin/numfmt --from=si
           -> "1000"
  $ echo 1K | /usr/local/bin/numfmt --from=iec
           -> "1024"
  $ df -B1 | /usr/local/bin/numfmt --header --field 2-4 --to=si
  $ ls -l  | /usr/local/bin/numfmt --header --field 5 --to=iec
  $ ls -lh | /usr/local/bin/numfmt --header --field 5 --from=iec --padding=10
  $ ls -lh | /usr/local/bin/numfmt --header --field 5 --from=iec --format %10f

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/numfmt>
or available locally via: info '(coreutils) numfmt invocation'
```

## coreutils_base32

### Tool Description
Base32 encode or decode FILE, or standard input, to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/base32 [OPTION]... [FILE]
Base32 encode or decode FILE, or standard input, to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -d, --decode          decode data
  -i, --ignore-garbage  when decoding, ignore non-alphabet characters
  -w, --wrap=COLS       wrap encoded lines after COLS character (default 76).
                          Use 0 to disable line wrapping
      --help        display this help and exit
      --version     output version information and exit

The data are encoded as described for the base32 alphabet in RFC 4648.
When decoding, the input may contain newlines in addition to the bytes of
the formal base32 alphabet.  Use --ignore-garbage to attempt to recover
from any other non-alphabet bytes in the encoded stream.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/base32>
or available locally via: info '(coreutils) base32 invocation'
```

## coreutils_base64

### Tool Description
Base64 encode or decode FILE, or standard input, to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/base64 [OPTION]... [FILE]
Base64 encode or decode FILE, or standard input, to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -d, --decode          decode data
  -i, --ignore-garbage  when decoding, ignore non-alphabet characters
  -w, --wrap=COLS       wrap encoded lines after COLS character (default 76).
                          Use 0 to disable line wrapping
      --help        display this help and exit
      --version     output version information and exit

The data are encoded as described for the base64 alphabet in RFC 4648.
When decoding, the input may contain newlines in addition to the bytes of
the formal base64 alphabet.  Use --ignore-garbage to attempt to recover
from any other non-alphabet bytes in the encoded stream.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/base64>
or available locally via: info '(coreutils) base64 invocation'
```

## coreutils_basenc

### Tool Description
basenc encode or decode FILE, or standard input, to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreutils:9.5
- **Homepage**: https://github.com/uutils/coreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/basenc [OPTION]... [FILE]
basenc encode or decode FILE, or standard input, to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
      --base64          same as 'base64' program (RFC4648 section 4)
      --base64url       file- and url-safe base64 (RFC4648 section 5)
      --base32          same as 'base32' program (RFC4648 section 6)
      --base32hex       extended hex alphabet base32 (RFC4648 section 7)
      --base16          hex encoding (RFC4648 section 8)
      --base2msbf       bit string with most significant bit (msb) first
      --base2lsbf       bit string with least significant bit (lsb) first
  -d, --decode          decode data
  -i, --ignore-garbage  when decoding, ignore non-alphabet characters
  -w, --wrap=COLS       wrap encoded lines after COLS character (default 76).
                          Use 0 to disable line wrapping
      --z85             ascii85-like encoding (ZeroMQ spec:32/Z85);
                        when encoding, input length must be a multiple of 4;
                        when decoding, input length must be a multiple of 5
      --help        display this help and exit
      --version     output version information and exit

When decoding, the input may contain newlines in addition to the bytes of
the formal alphabet.  Use --ignore-garbage to attempt to recover
from any other non-alphabet bytes in the encoded stream.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report any translation bugs to <https://translationproject.org/team/>
Full documentation <https://www.gnu.org/software/coreutils/basenc>
or available locally via: info '(coreutils) basenc invocation'
```

