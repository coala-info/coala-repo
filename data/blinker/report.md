# blinker CWL Generation Report

## blinker_ls

### Tool Description
List directory contents

### Metadata
- **Docker Image**: quay.io/biocontainers/blinker:1.4--py35_0
- **Homepage**: https://github.com/blinksh/blink
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/main/packages/blinker/overview
- **Total Downloads**: 26.4K
- **Last updated**: 2025-12-01
- **GitHub**: https://github.com/blinksh/blink
- **Stars**: N/A
### Original Help Text
```text
total 48
drwxrwxr-x    1 root     root        4.0K Mon May  9 06:21:01 2016 bin/
drwxr-xr-x    5 root     root         340 Wed Feb 25 15:21:42 2026 dev/
drwxr-xr-x    1 root     root        4.0K Wed Feb 25 15:21:40 2026 etc/
drwxrwxr-x    4 root     root        4.0K Fri May 23 01:26:38 2014 home/
drwxr-xr-x    1 root     root        4.0K Tue Aug 11 21:02:14 2015 lib/
lrwxrwxrwx    1 root     root           3 Fri May 23 00:41:54 2014 lib64 -> lib/
lrwxrwxrwx    1 root     root          11 Fri May 23 01:25:01 2014 linuxrc -> bin/busybox
drwxrwxr-x    2 root     root        4.0K Thu Feb 27 20:51:23 2014 media/
drwxrwxr-x    2 root     root        4.0K Thu Feb 27 20:51:23 2014 mnt/
drwxrwxr-x    2 root     root        4.0K Thu Feb 27 20:51:23 2014 opt/
dr-xr-xr-x  814 root     root           0 Wed Feb 25 15:21:42 2026 proc/
drwx------    2 root     root        4.0K Thu Feb 27 20:51:23 2014 root/
lrwxrwxrwx    1 root     root           3 Thu Feb 27 20:51:23 2014 run -> tmp/
drwxrwxr-x    2 root     root        4.0K Fri May 23 01:25:01 2014 sbin/
dr-xr-xr-x   13 root     root           0 Wed Feb 25 15:21:42 2026 sys/
drwxrwxrwt    3 root     root        4.0K Fri May 23 01:26:21 2014 tmp/
drwxr-xr-x    1 root     root        4.0K Thu Sep  8 01:26:46 2016 usr/
drwxrwxr-x    4 root     root        4.0K Fri May 23 01:26:38 2014 var/
```


## blinker_cp

### Tool Description
Copy SOURCE(s) to DEST

### Metadata
- **Docker Image**: quay.io/biocontainers/blinker:1.4--py35_0
- **Homepage**: https://github.com/blinksh/blink
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.22.1 (2014-05-23 01:24:27 UTC) multi-call binary.

Usage: cp [OPTIONS] SOURCE... DEST

Copy SOURCE(s) to DEST

	-a	Same as -dpR
	-R,-r	Recurse
	-d,-P	Preserve symlinks (default if -R)
	-L	Follow all symlinks
	-H	Follow symlinks on command line
	-p	Preserve file attributes if possible
	-f	Overwrite
	-i	Prompt before overwrite
	-l,-s	Create (sym)links
```


## blinker_mv

### Tool Description
Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY

### Metadata
- **Docker Image**: quay.io/biocontainers/blinker:1.4--py35_0
- **Homepage**: https://github.com/blinksh/blink
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.22.1 (2014-05-23 01:24:27 UTC) multi-call binary.

Usage: mv [-fin] SOURCE DEST
or: mv [-fin] SOURCE... DIRECTORY

Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY

	-f	Don't prompt before overwriting
	-i	Interactive, prompt before overwrite
	-n	Don't overwrite an existing file
```


## blinker_rm

### Tool Description
Remove (unlink) FILEs

### Metadata
- **Docker Image**: quay.io/biocontainers/blinker:1.4--py35_0
- **Homepage**: https://github.com/blinksh/blink
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.22.1 (2014-05-23 01:24:27 UTC) multi-call binary.

Usage: rm [-irf] FILE...

Remove (unlink) FILEs

	-i	Always prompt before removing
	-f	Never prompt
	-R,-r	Recurse
```


## blinker_mkdir

### Tool Description
Create DIRECTORY

### Metadata
- **Docker Image**: quay.io/biocontainers/blinker:1.4--py35_0
- **Homepage**: https://github.com/blinksh/blink
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.22.1 (2014-05-23 01:24:27 UTC) multi-call binary.

Usage: mkdir [OPTIONS] DIRECTORY...

Create DIRECTORY

	-m MODE	Mode
	-p	No error if exists; make parent directories as needed
```


## blinker_tar

### Tool Description
Create, extract, or list files from a tar file

### Metadata
- **Docker Image**: quay.io/biocontainers/blinker:1.4--py35_0
- **Homepage**: https://github.com/blinksh/blink
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.22.1 (2014-05-23 01:24:27 UTC) multi-call binary.

Usage: tar -[cxthvO] [-X FILE] [-T FILE] [-f TARFILE] [-C DIR] [FILE]...

Create, extract, or list files from a tar file

Operation:
	c	Create
	x	Extract
	t	List
	f	Name of TARFILE ('-' for stdin/out)
	C	Change to DIR before operation
	v	Verbose
	O	Extract to stdout
	h	Follow symlinks
	exclude	File to exclude
	X	File with names to exclude
	T	File with names to include
```


## blinker_grep

### Tool Description
Search for PATTERN in FILEs (or stdin)

### Metadata
- **Docker Image**: quay.io/biocontainers/blinker:1.4--py35_0
- **Homepage**: https://github.com/blinksh/blink
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.22.1 (2014-05-23 01:24:27 UTC) multi-call binary.

Usage: grep [-HhnlLoqvsriwFE] [-m N] [-A/B/C N] PATTERN/-e PATTERN.../-f FILE [FILE]...

Search for PATTERN in FILEs (or stdin)

	-H	Add 'filename:' prefix
	-h	Do not add 'filename:' prefix
	-n	Add 'line_no:' prefix
	-l	Show only names of files that match
	-L	Show only names of files that don't match
	-c	Show only count of matching lines
	-o	Show only the matching part of line
	-q	Quiet. Return 0 if PATTERN is found, 1 otherwise
	-v	Select non-matching lines
	-s	Suppress open and read errors
	-r	Recurse
	-i	Ignore case
	-w	Match whole words only
	-x	Match whole lines only
	-F	PATTERN is a literal (not regexp)
	-E	PATTERN is an extended regexp
	-m N	Match up to N times per file
	-A N	Print N lines of trailing context
	-B N	Print N lines of leading context
	-C N	Same as '-A N -B N'
	-e PTRN	Pattern to match
	-f FILE	Read pattern from file
```


## blinker_python

### Tool Description
Run a Python script or module

### Metadata
- **Docker Image**: quay.io/biocontainers/blinker:1.4--py35_0
- **Homepage**: https://github.com/blinksh/blink
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: python [option] ... [-c cmd | -m mod | file | -] [arg] ...
Options and arguments (and corresponding environment variables):
-b     : issue warnings about str(bytes_instance), str(bytearray_instance)
         and comparing bytes/bytearray with str. (-bb: issue errors)
-B     : don't write .py[co] files on import; also PYTHONDONTWRITEBYTECODE=x
-c cmd : program passed in as string (terminates option list)
-d     : debug output from parser; also PYTHONDEBUG=x
-E     : ignore PYTHON* environment variables (such as PYTHONPATH)
-h     : print this help message and exit (also --help)
-i     : inspect interactively after running script; forces a prompt even
         if stdin does not appear to be a terminal; also PYTHONINSPECT=x
-I     : isolate Python from the user's environment (implies -E and -s)
-m mod : run library module as a script (terminates option list)
-O     : optimize generated bytecode slightly; also PYTHONOPTIMIZE=x
-OO    : remove doc-strings in addition to the -O optimizations
-q     : don't print version and copyright messages on interactive startup
-s     : don't add user site directory to sys.path; also PYTHONNOUSERSITE
-S     : don't imply 'import site' on initialization
-u     : unbuffered binary stdout and stderr, stdin always buffered;
         also PYTHONUNBUFFERED=x
         see man page for details on internal buffering relating to '-u'
-v     : verbose (trace import statements); also PYTHONVERBOSE=x
         can be supplied multiple times to increase verbosity
-V     : print the Python version number and exit (also --version)
-W arg : warning control; arg is action:message:category:module:lineno
         also PYTHONWARNINGS=arg
-x     : skip first line of source, allowing use of non-Unix forms of #!cmd
-X opt : set implementation-specific option
file   : program read from script file
-      : program read from stdin (default; interactive mode if a tty)
arg ...: arguments passed to program in sys.argv[1:]

Other environment variables:
PYTHONSTARTUP: file executed on interactive startup (no default)
PYTHONPATH   : ':'-separated list of directories prefixed to the
               default module search path.  The result is sys.path.
PYTHONHOME   : alternate <prefix> directory (or <prefix>:<exec_prefix>).
               The default module search path uses <prefix>/pythonX.X.
PYTHONCASEOK : ignore case in 'import' statements (Windows).
PYTHONIOENCODING: Encoding[:errors] used for stdin/stdout/stderr.
PYTHONFAULTHANDLER: dump the Python traceback on fatal errors.
PYTHONHASHSEED: if this variable is set to 'random', a random value is used
   to seed the hashes of str, bytes and datetime objects.  It can also be
   set to an integer in the range [0,4294967295] to get hash values with a
   predictable seed.
```


## Metadata
- **Skill**: generated
