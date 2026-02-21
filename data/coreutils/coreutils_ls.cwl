cwlVersion: v1.2
class: CommandLineTool
baseCommand: ls
label: coreutils_ls
doc: "List information about the FILEs (the current directory by default). Sort entries
  alphabetically if none of -cftuSUX nor --sort is specified.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files or directories to list
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
  - id: block_size
    type:
      - 'null'
      - string
    doc: with -l, scale sizes by SIZE when printing them; e.g., '--block-size=M';
      see SIZE format below
    inputBinding:
      position: 102
      prefix: --block-size
  - id: classify
    type:
      - 'null'
      - boolean
    doc: append indicator (one of */=>@|) to entries
    inputBinding:
      position: 102
      prefix: --classify
  - id: dereference
    type:
      - 'null'
      - boolean
    doc: when showing file information for a symbolic link, show information for the
      file the link references rather than for the link itself
    inputBinding:
      position: 102
      prefix: --dereference
  - id: directory
    type:
      - 'null'
      - boolean
    doc: list directories themselves, not their contents
    inputBinding:
      position: 102
      prefix: --directory
  - id: escape
    type:
      - 'null'
      - boolean
    doc: print C-style escapes for nongraphic characters
    inputBinding:
      position: 102
      prefix: --escape
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: with -l and -s, print sizes like 1K 234M 2G etc.
    inputBinding:
      position: 102
      prefix: --human-readable
  - id: ignore_backups
    type:
      - 'null'
      - boolean
    doc: do not list implied entries ending with ~
    inputBinding:
      position: 102
      prefix: --ignore-backups
  - id: inode
    type:
      - 'null'
      - boolean
    doc: print the index number of each file
    inputBinding:
      position: 102
      prefix: --inode
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: use a long listing format
    inputBinding:
      position: 102
      prefix: -l
  - id: one_line
    type:
      - 'null'
      - boolean
    doc: list one file per line
    inputBinding:
      position: 102
      prefix: '-1'
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: list subdirectories recursively
    inputBinding:
      position: 102
      prefix: --recursive
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse order while sorting
    inputBinding:
      position: 102
      prefix: --reverse
  - id: sort_by_size
    type:
      - 'null'
      - boolean
    doc: sort by file size, largest first
    inputBinding:
      position: 102
      prefix: -S
  - id: sort_by_time
    type:
      - 'null'
      - boolean
    doc: sort by modification time, newest first
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_ls.out
