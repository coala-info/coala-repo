cwlVersion: v1.2
class: CommandLineTool
baseCommand: rename
label: rename
doc: "Rename files according to a pattern.\n\nTool homepage: http://plasmasturm.org/code/rename"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to rename
    inputBinding:
      position: 1
  - id: append
    type:
      - 'null'
      - string
    doc: append string to filenames
    inputBinding:
      position: 102
      prefix: --append
  - id: backwards
    type:
      - 'null'
      - boolean
    doc: process files in reverse order
    inputBinding:
      position: 102
      prefix: --backwards
  - id: camelcase
    type:
      - 'null'
      - boolean
    doc: convert filenames to camel case
    inputBinding:
      position: 102
      prefix: --camelcase
  - id: counter_format
    type:
      - 'null'
      - string
    doc: specify counter format
    inputBinding:
      position: 102
      prefix: --counter-format
  - id: delete
    type:
      - 'null'
      - string
    doc: delete specified string from filenames
    inputBinding:
      position: 102
      prefix: --delete
  - id: delete_all
    type:
      - 'null'
      - string
    doc: delete all occurrences of specified string from filenames
    inputBinding:
      position: 102
      prefix: --delete-all
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: do not rename, just print what would be done
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: expr
    type:
      - 'null'
      - string
    doc: apply Perl expression to filenames
    inputBinding:
      position: 102
      prefix: --expr
  - id: force
    type:
      - 'null'
      - boolean
    doc: proceed when overwriting
    inputBinding:
      position: 102
      prefix: --force
  - id: glob
    type:
      - 'null'
      - boolean
    doc: expand "*" etc. in filenames, useful in Windows™ CMD.EXE
    inputBinding:
      position: 102
      prefix: --glob
  - id: hardlink
    type:
      - 'null'
      - boolean
    doc: create hard links
    inputBinding:
      position: 102
      prefix: --hardlink
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: prompt when overwriting
    inputBinding:
      position: 102
      prefix: --interactive
  - id: just_print
    type:
      - 'null'
      - boolean
    doc: do not rename, just print what would be done
    inputBinding:
      position: 102
      prefix: --just-print
  - id: keep_extension
    type:
      - 'null'
      - boolean
    doc: keep file extension
    inputBinding:
      position: 102
      prefix: --keep-extension
  - id: lower_case
    type:
      - 'null'
      - boolean
    doc: convert filenames to lower case
    inputBinding:
      position: 102
      prefix: --lower-case
  - id: make_dirs
    type:
      - 'null'
      - boolean
    doc: create parent directories as needed
    inputBinding:
      position: 102
      prefix: --make-dirs
  - id: man
    type:
      - 'null'
      - boolean
    doc: read the full manual
    inputBinding:
      position: 102
      prefix: --man
  - id: mkpath
    type:
      - 'null'
      - boolean
    doc: create parent directories as needed
    inputBinding:
      position: 102
      prefix: --mkpath
  - id: no_stdin
    type:
      - 'null'
      - boolean
    doc: do not read filenames from standard input
    inputBinding:
      position: 102
      prefix: --no-stdin
  - id: noctrl
    type:
      - 'null'
      - boolean
    doc: remove control characters from filenames
    inputBinding:
      position: 102
      prefix: --noctrl
  - id: nometa
    type:
      - 'null'
      - boolean
    doc: remove metadata characters from filenames
    inputBinding:
      position: 102
      prefix: --nometa
  - id: nows
    type:
      - 'null'
      - boolean
    doc: remove whitespace from filenames
    inputBinding:
      position: 102
      prefix: --nows
  - id: null_input
    type:
      - 'null'
      - boolean
    doc: when reading from STDIN
    inputBinding:
      position: 102
      prefix: --null
  - id: pipe
    type:
      - 'null'
      - string
    doc: pipe filenames through external command
    inputBinding:
      position: 102
      prefix: --pipe
  - id: prepend
    type:
      - 'null'
      - string
    doc: prepend string to filenames
    inputBinding:
      position: 102
      prefix: --prepend
  - id: remove_extension
    type:
      - 'null'
      - boolean
    doc: remove file extension
    inputBinding:
      position: 102
      prefix: --remove-extension
  - id: reverse_order
    type:
      - 'null'
      - boolean
    doc: process files in reverse order
    inputBinding:
      position: 102
      prefix: --reverse-order
  - id: rews
    type:
      - 'null'
      - boolean
    doc: replace whitespace with underscores in filenames
    inputBinding:
      position: 102
      prefix: --rews
  - id: sanitize
    type:
      - 'null'
      - boolean
    doc: sanitize filenames (remove invalid characters)
    inputBinding:
      position: 102
      prefix: --sanitize
  - id: sort_time
    type:
      - 'null'
      - boolean
    doc: sort files by modification time
    inputBinding:
      position: 102
      prefix: --sort-time
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: read filenames from standard input
    inputBinding:
      position: 102
      prefix: --stdin
  - id: subst
    type:
      - 'null'
      - type: array
        items: string
    doc: substitute first occurrence of 'from' with 'to' in filenames
    inputBinding:
      position: 102
      prefix: --subst
  - id: subst_all
    type:
      - 'null'
      - type: array
        items: string
    doc: substitute all occurrences of 'from' with 'to' in filenames
    inputBinding:
      position: 102
      prefix: --subst-all
  - id: symlink
    type:
      - 'null'
      - boolean
    doc: create symbolic links
    inputBinding:
      position: 102
      prefix: --symlink
  - id: transcode
    type:
      - 'null'
      - string
    doc: transcode filenames to specified encoding
    inputBinding:
      position: 102
      prefix: --transcode
  - id: trim
    type:
      - 'null'
      - boolean
    doc: trim leading/trailing whitespace from filenames
    inputBinding:
      position: 102
      prefix: --trim
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: convert filenames to upper case
    inputBinding:
      position: 102
      prefix: --upper-case
  - id: urlesc
    type:
      - 'null'
      - boolean
    doc: URL-encode filenames
    inputBinding:
      position: 102
      prefix: --urlesc
  - id: use_module
    type:
      - 'null'
      - string
    doc: use specified module
    inputBinding:
      position: 102
      prefix: --use
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rename:1.601--0
stdout: rename.out
