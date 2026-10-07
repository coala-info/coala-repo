cwlVersion: v1.2
class: CommandLineTool
baseCommand: du
label: coreutils_du
doc: "Estimate file space usage\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Files or directories to estimate space usage for
    inputBinding:
      position: 1
  - id: null_terminated
    type:
      - 'null'
      - boolean
    doc: "end each output line with NUL, not newline"
    inputBinding:
      position: 102
      prefix: --null
  - id: all
    type:
      - 'null'
      - boolean
    doc: "write counts for all files, not just directories"
    inputBinding:
      position: 102
      prefix: --all
  - id: apparent_size
    type:
      - 'null'
      - boolean
    doc: "print apparent sizes rather than device usage"
    inputBinding:
      position: 102
      prefix: --apparent-size
  - id: block_size
    type:
      - 'null'
      - string
    doc: "scale sizes by SIZE before printing them; e.g., M prints sizes in units of 1,048,576 bytes"
    inputBinding:
      position: 102
      prefix: --block-size=
      separate: false
  - id: bytes
    type:
      - 'null'
      - boolean
    doc: "equivalent to '--apparent-size --block-size=1'"
    inputBinding:
      position: 102
      prefix: --bytes
  - id: total
    type:
      - 'null'
      - boolean
    doc: "produce a grand total"
    inputBinding:
      position: 102
      prefix: --total
  - id: dereference_args
    type:
      - 'null'
      - boolean
    doc: "dereference only symlinks that are listed on the command line"
    inputBinding:
      position: 102
      prefix: --dereference-args
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "print the total for a directory (or file, with --all) only if it is N or fewer levels below the command line argument"
    inputBinding:
      position: 102
      prefix: --max-depth=
      separate: false
  - id: files0_from
    type:
      - 'null'
      - File
    doc: "summarize device usage of the NUL-terminated file names specified in file F"
    inputBinding:
      position: 102
      prefix: --files0-from=
      separate: false
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: "print sizes in human readable format (e.g., 1K 234M 2G)"
    inputBinding:
      position: 102
      prefix: --human-readable
  - id: inodes
    type:
      - 'null'
      - boolean
    doc: "list inode usage information instead of block usage"
    inputBinding:
      position: 102
      prefix: --inodes
  - id: kilobytes
    type:
      - 'null'
      - boolean
    doc: "like --block-size=1K"
    inputBinding:
      position: 102
      prefix: -k
  - id: dereference
    type:
      - 'null'
      - boolean
    doc: "dereference all symbolic links"
    inputBinding:
      position: 102
      prefix: --dereference
  - id: count_links
    type:
      - 'null'
      - boolean
    doc: "count sizes many times if hard linked"
    inputBinding:
      position: 102
      prefix: --count-links
  - id: megabytes
    type:
      - 'null'
      - boolean
    doc: "like --block-size=1M"
    inputBinding:
      position: 102
      prefix: -m
  - id: no_dereference
    type:
      - 'null'
      - boolean
    doc: "don't follow any symbolic links (this is the default)"
    inputBinding:
      position: 102
      prefix: --no-dereference
  - id: separate_dirs
    type:
      - 'null'
      - boolean
    doc: "for directories do not include size of subdirectories"
    inputBinding:
      position: 102
      prefix: --separate-dirs
  - id: si
    type:
      - 'null'
      - boolean
    doc: "like -h, but use powers of 1000 not 1024"
    inputBinding:
      position: 102
      prefix: --si
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: "display only a total for each argument"
    inputBinding:
      position: 102
      prefix: --summarize
  - id: threshold
    type:
      - 'null'
      - string
    doc: "exclude entries smaller than SIZE if positive, or entries greater than SIZE if negative"
    inputBinding:
      position: 102
      prefix: --threshold=
      separate: false
  - id: time
    type:
      - 'null'
      - boolean
    doc: "show time of the last modification of any file in the directory, or any of its subdirectories"
    inputBinding:
      position: 102
      prefix: --time
  - id: time_word
    type:
      - 'null'
      - string
    doc: "show time as WORD instead of modification time: atime, access, use, ctime or status"
    inputBinding:
      position: 102
      prefix: --time=
      separate: false
  - id: time_style
    type:
      - 'null'
      - string
    doc: "show times using STYLE: full-iso, long-iso, iso, or +FORMAT"
    inputBinding:
      position: 102
      prefix: --time-style=
      separate: false
  - id: exclude_from
    type:
      - 'null'
      - File
    doc: "exclude files that match any pattern in FILE"
    inputBinding:
      position: 102
      prefix: --exclude-from=
      separate: false
  - id: exclude
    type:
      - 'null'
      - string
    doc: "exclude files that match PATTERN"
    inputBinding:
      position: 102
      prefix: --exclude=
      separate: false
  - id: one_file_system
    type:
      - 'null'
      - boolean
    doc: "skip directories on different file systems"
    inputBinding:
      position: 102
      prefix: --one-file-system
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_du.out
