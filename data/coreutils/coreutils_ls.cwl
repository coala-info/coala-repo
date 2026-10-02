cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/ls
label: coreutils_ls
doc: List information about the FILEs (the current directory by default). Sort 
  entries alphabetically if none of -cftuvSUX nor --sort is specified.
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: FILEs to list information about (the current directory by default)
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: do not ignore entries starting with .
    inputBinding:
      position: 102
      prefix: --all
  - id: almost_all
    type:
      - 'null'
      - boolean
    doc: do not list implied . and ..
    inputBinding:
      position: 102
      prefix: --almost-all
  - id: author
    type:
      - 'null'
      - boolean
    doc: with -l, print the author of each file
    inputBinding:
      position: 102
      prefix: --author
  - id: escape
    type:
      - 'null'
      - boolean
    doc: print C-style escapes for nongraphic characters
    inputBinding:
      position: 102
      prefix: --escape
  - id: block_size
    type:
      - 'null'
      - string
    doc: with -l, scale sizes by SIZE when printing them; e.g., 
      '--block-size=M'; see SIZE format below
    inputBinding:
      position: 102
      prefix: --block-size
  - id: ignore_backups
    type:
      - 'null'
      - boolean
    doc: do not list implied entries ending with ~
    inputBinding:
      position: 102
      prefix: --ignore-backups
  - id: sort_ctime
    type:
      - 'null'
      - boolean
    doc: 'with -lt: sort by, and show, ctime (time of last change of file status information);
      with -l: show ctime and sort by name; otherwise: sort by ctime, newest first'
    inputBinding:
      position: 102
      prefix: -c
  - id: columns
    type:
      - 'null'
      - boolean
    doc: list entries by columns
    inputBinding:
      position: 102
      prefix: -C
  - id: color
    type:
      - 'null'
      - string
    doc: color the output WHEN; more info below
    inputBinding:
      position: 102
      prefix: --color=
      separate: false
  - id: directory
    type:
      - 'null'
      - boolean
    doc: list directories themselves, not their contents
    inputBinding:
      position: 102
      prefix: --directory
  - id: dired
    type:
      - 'null'
      - boolean
    doc: generate output designed for Emacs' dired mode
    inputBinding:
      position: 102
      prefix: --dired
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: do not sort, enable -aU, disable -ls --color
    inputBinding:
      position: 102
      prefix: -f
  - id: classify
    type:
      - 'null'
      - string
    doc: append indicator (one of */=>@|) to entries WHEN
    inputBinding:
      position: 102
      prefix: --classify=
      separate: false
  - id: file_type
    type:
      - 'null'
      - boolean
    doc: likewise, except do not append '*'
    inputBinding:
      position: 102
      prefix: --file-type
  - id: format
    type:
      - 'null'
      - string
    doc: across -x, commas -m, horizontal -x, long -l, single-column -1, verbose
      -l, vertical -C
    inputBinding:
      position: 102
      prefix: --format
  - id: full_time
    type:
      - 'null'
      - boolean
    doc: like -l --time-style=full-iso
    inputBinding:
      position: 102
      prefix: --full-time
  - id: no_owner
    type:
      - 'null'
      - boolean
    doc: like -l, but do not list owner
    inputBinding:
      position: 102
      prefix: -g
  - id: group_directories_first
    type:
      - 'null'
      - boolean
    doc: group directories before files; can be augmented with a --sort option, 
      but any use of --sort=none (-U) disables grouping
    inputBinding:
      position: 102
      prefix: --group-directories-first
  - id: no_group
    type:
      - 'null'
      - boolean
    doc: in a long listing, don't print group names
    inputBinding:
      position: 102
      prefix: --no-group
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: with -l and -s, print sizes like 1K 234M 2G etc.
    inputBinding:
      position: 102
      prefix: --human-readable
  - id: si
    type:
      - 'null'
      - boolean
    doc: likewise, but use powers of 1000 not 1024
    inputBinding:
      position: 102
      prefix: --si
  - id: dereference_command_line
    type:
      - 'null'
      - boolean
    doc: follow symbolic links listed on the command line
    inputBinding:
      position: 102
      prefix: --dereference-command-line
  - id: dereference_command_line_symlink_to_dir
    type:
      - 'null'
      - boolean
    doc: follow each command line symbolic link that points to a directory
    inputBinding:
      position: 102
      prefix: --dereference-command-line-symlink-to-dir
  - id: hide
    type:
      - 'null'
      - string
    doc: do not list implied entries matching shell PATTERN (overridden by -a or
      -A)
    inputBinding:
      position: 102
      prefix: --hide
  - id: hyperlink
    type:
      - 'null'
      - string
    doc: hyperlink file names WHEN
    inputBinding:
      position: 102
      prefix: --hyperlink=
      separate: false
  - id: indicator_style
    type:
      - 'null'
      - string
    doc: 'append indicator with style WORD to entry names: none (default), slash (-p),
      file-type (--file-type), classify (-F)'
    inputBinding:
      position: 102
      prefix: --indicator-style
  - id: inode
    type:
      - 'null'
      - boolean
    doc: print the index number of each file
    inputBinding:
      position: 102
      prefix: --inode
  - id: ignore
    type:
      - 'null'
      - string
    doc: do not list implied entries matching shell PATTERN
    inputBinding:
      position: 102
      prefix: --ignore
  - id: kibibytes
    type:
      - 'null'
      - boolean
    doc: default to 1024-byte blocks for file system usage; used only with -s 
      and per directory totals
    inputBinding:
      position: 102
      prefix: --kibibytes
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: use a long listing format
    inputBinding:
      position: 102
      prefix: -l
  - id: dereference
    type:
      - 'null'
      - boolean
    doc: when showing file information for a symbolic link, show information for
      the file the link references rather than for the link itself
    inputBinding:
      position: 102
      prefix: --dereference
  - id: comma_separated
    type:
      - 'null'
      - boolean
    doc: fill width with a comma separated list of entries
    inputBinding:
      position: 102
      prefix: -m
  - id: numeric_uid_gid
    type:
      - 'null'
      - boolean
    doc: like -l, but list numeric user and group IDs
    inputBinding:
      position: 102
      prefix: --numeric-uid-gid
  - id: literal
    type:
      - 'null'
      - boolean
    doc: print entry names without quoting
    inputBinding:
      position: 102
      prefix: --literal
  - id: no_group_info
    type:
      - 'null'
      - boolean
    doc: like -l, but do not list group information
    inputBinding:
      position: 102
      prefix: -o
  - id: indicator_style_slash
    type:
      - 'null'
      - boolean
    doc: append / indicator to directories
    inputBinding:
      position: 102
      prefix: -p
  - id: hide_control_chars
    type:
      - 'null'
      - boolean
    doc: print ? instead of nongraphic characters
    inputBinding:
      position: 102
      prefix: --hide-control-chars
  - id: show_control_chars
    type:
      - 'null'
      - boolean
    doc: show nongraphic characters as-is (the default, unless program is 'ls' 
      and output is a terminal)
    inputBinding:
      position: 102
      prefix: --show-control-chars
  - id: quote_name
    type:
      - 'null'
      - boolean
    doc: enclose entry names in double quotes
    inputBinding:
      position: 102
      prefix: --quote-name
  - id: quoting_style
    type:
      - 'null'
      - string
    doc: 'use quoting style WORD for entry names: literal, locale, shell, shell-always,
      shell-escape, shell-escape-always, c, escape (overrides QUOTING_STYLE environment
      variable)'
    inputBinding:
      position: 102
      prefix: --quoting-style
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse order while sorting
    inputBinding:
      position: 102
      prefix: --reverse
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: list subdirectories recursively
    inputBinding:
      position: 102
      prefix: --recursive
  - id: size
    type:
      - 'null'
      - boolean
    doc: print the allocated size of each file, in blocks
    inputBinding:
      position: 102
      prefix: --size
  - id: sort_by_size
    type:
      - 'null'
      - boolean
    doc: sort by file size, largest first
    inputBinding:
      position: 102
      prefix: -S
  - id: sort
    type:
      - 'null'
      - string
    doc: 'sort by WORD instead of name: none (-U), size (-S), time (-t), version (-v),
      extension (-X), width'
    inputBinding:
      position: 102
      prefix: --sort
  - id: time
    type:
      - 'null'
      - string
    doc: 'select which timestamp used to display or sort; access time (-u): atime,
      access, use; metadata change time (-c): ctime, status; modified time (default):
      mtime, modification; birth time: birth, creation; with -l, WORD determines which
      time to show; with --sort=time, sort by WORD (newest first)'
    inputBinding:
      position: 102
      prefix: --time
  - id: time_style
    type:
      - 'null'
      - string
    doc: time/date format with -l; see TIME_STYLE below
    inputBinding:
      position: 102
      prefix: --time-style
  - id: sort_by_time
    type:
      - 'null'
      - boolean
    doc: sort by time, newest first; see --time
    inputBinding:
      position: 102
      prefix: -t
  - id: tabsize
    type:
      - 'null'
      - int
    doc: assume tab stops at each COLS instead of 8
    inputBinding:
      position: 102
      prefix: --tabsize
  - id: access_time
    type:
      - 'null'
      - boolean
    doc: 'with -lt: sort by, and show, access time; with -l: show access time and
      sort by name; otherwise: sort by access time, newest first'
    inputBinding:
      position: 102
      prefix: -u
  - id: directory_order
    type:
      - 'null'
      - boolean
    doc: do not sort; list entries in directory order
    inputBinding:
      position: 102
      prefix: -U
  - id: version_sort
    type:
      - 'null'
      - boolean
    doc: natural sort of (version) numbers within text
    inputBinding:
      position: 102
      prefix: -v
  - id: width
    type:
      - 'null'
      - int
    doc: set output width to COLS. 0 means no limit
    inputBinding:
      position: 102
      prefix: --width
  - id: by_lines
    type:
      - 'null'
      - boolean
    doc: list entries by lines instead of by columns
    inputBinding:
      position: 102
      prefix: -x
  - id: sort_by_extension
    type:
      - 'null'
      - boolean
    doc: sort alphabetically by entry extension
    inputBinding:
      position: 102
      prefix: -X
  - id: context
    type:
      - 'null'
      - boolean
    doc: print any security context of each file
    inputBinding:
      position: 102
      prefix: --context
  - id: zero
    type:
      - 'null'
      - boolean
    doc: end each output line with NUL, not newline
    inputBinding:
      position: 102
      prefix: --zero
  - id: one_file_per_line
    type:
      - 'null'
      - boolean
    doc: list one file per line
    inputBinding:
      position: 102
      prefix: '-1'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: ls.out
s:url: https://github.com/uutils/coreutils
$namespaces:
  s: https://schema.org/
