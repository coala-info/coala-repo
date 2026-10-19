cwlVersion: v1.2
class: CommandLineTool
baseCommand: rename
label: rename
doc: "Rename files according to a pattern.\n\nTool homepage: http://plasmasturm.org/code/rename"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Files to rename (copied into the working directory)
    inputBinding:
      position: 200
  - id: append
    type:
      - 'null'
      - string
    doc: append string to filenames
    inputBinding:
      position: 101
      prefix: --append
  - id: backwards
    type:
      - 'null'
      - boolean
    doc: process files in reverse order
    inputBinding:
      position: 101
      prefix: --backwards
  - id: camelcase
    type:
      - 'null'
      - boolean
    doc: convert filenames to camel case
    inputBinding:
      position: 101
      prefix: --camelcase
  - id: counter_format
    type:
      - 'null'
      - string
    doc: specify counter format
    inputBinding:
      position: 101
      prefix: --counter-format
  - id: delete
    type:
      - 'null'
      - string
    doc: delete specified string from filenames
    inputBinding:
      position: 101
      prefix: --delete
  - id: delete_all
    type:
      - 'null'
      - string
    doc: delete all occurrences of specified string from filenames
    inputBinding:
      position: 101
      prefix: --delete-all
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: do not rename, just print what would be done
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: expr
    type:
      - 'null'
      - string
    doc: apply Perl expression to filenames
    inputBinding:
      position: 101
      prefix: --expr
  - id: force
    type:
      - 'null'
      - boolean
    doc: proceed when overwriting
    inputBinding:
      position: 101
      prefix: --force
  - id: glob
    type:
      - 'null'
      - boolean
    doc: expand "*" etc. in filenames, useful in Windows™ CMD.EXE
    inputBinding:
      position: 101
      prefix: --glob
  - id: hardlink
    type:
      - 'null'
      - boolean
    doc: create hard links
    inputBinding:
      position: 101
      prefix: --hardlink
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: prompt when overwriting
    inputBinding:
      position: 101
      prefix: --interactive
  - id: just_print
    type:
      - 'null'
      - boolean
    doc: do not rename, just print what would be done
    inputBinding:
      position: 101
      prefix: --just-print
  - id: keep_extension
    type:
      - 'null'
      - boolean
    doc: keep file extension
    inputBinding:
      position: 101
      prefix: --keep-extension
  - id: lower_case
    type:
      - 'null'
      - boolean
    doc: convert filenames to lower case
    inputBinding:
      position: 101
      prefix: --lower-case
  - id: make_dirs
    type:
      - 'null'
      - boolean
    doc: create parent directories as needed
    inputBinding:
      position: 101
      prefix: --make-dirs
  - id: mkpath
    type:
      - 'null'
      - boolean
    doc: create parent directories as needed
    inputBinding:
      position: 101
      prefix: --mkpath
  - id: no_stdin
    type:
      - 'null'
      - boolean
    doc: do not read filenames from standard input
    inputBinding:
      position: 101
      prefix: --no-stdin
  - id: noctrl
    type:
      - 'null'
      - boolean
    doc: remove control characters from filenames
    inputBinding:
      position: 101
      prefix: --noctrl
  - id: nometa
    type:
      - 'null'
      - boolean
    doc: remove metadata characters from filenames
    inputBinding:
      position: 101
      prefix: --nometa
  - id: nows
    type:
      - 'null'
      - boolean
    doc: remove whitespace from filenames
    inputBinding:
      position: 101
      prefix: --nows
  - id: null_input
    type:
      - 'null'
      - boolean
    doc: when reading from STDIN
    inputBinding:
      position: 101
      prefix: --null
  - id: pipe
    type:
      - 'null'
      - string
    doc: pipe filenames through external command
    inputBinding:
      position: 101
      prefix: --pipe
  - id: prepend
    type:
      - 'null'
      - string
    doc: prepend string to filenames
    inputBinding:
      position: 101
      prefix: --prepend
  - id: remove_extension
    type:
      - 'null'
      - boolean
    doc: remove file extension
    inputBinding:
      position: 101
      prefix: --remove-extension
  - id: reverse_order
    type:
      - 'null'
      - boolean
    doc: process files in reverse order
    inputBinding:
      position: 101
      prefix: --reverse-order
  - id: rews
    type:
      - 'null'
      - boolean
    doc: replace whitespace with underscores in filenames
    inputBinding:
      position: 101
      prefix: --rews
  - id: sanitize
    type:
      - 'null'
      - boolean
    doc: sanitize filenames (remove invalid characters)
    inputBinding:
      position: 101
      prefix: --sanitize
  - id: sort_time
    type:
      - 'null'
      - boolean
    doc: sort files by modification time
    inputBinding:
      position: 101
      prefix: --sort-time
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: read filenames from standard input
    inputBinding:
      position: 101
      prefix: --stdin
  - id: subst
    type:
      - 'null'
      - type: array
        items: string
    doc: substitute first occurrence of 'from' with 'to' in filenames
    inputBinding:
      position: 101
      prefix: --subst
  - id: subst_all
    type:
      - 'null'
      - type: array
        items: string
    doc: substitute all occurrences of 'from' with 'to' in filenames
    inputBinding:
      position: 101
      prefix: --subst-all
  - id: symlink
    type:
      - 'null'
      - boolean
    doc: create symbolic links
    inputBinding:
      position: 101
      prefix: --symlink
  - id: transcode
    type:
      - 'null'
      - string
    doc: transcode filenames to specified encoding
    inputBinding:
      position: 101
      prefix: --transcode
  - id: trim
    type:
      - 'null'
      - boolean
    doc: trim leading/trailing whitespace from filenames
    inputBinding:
      position: 101
      prefix: --trim
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: convert filenames to upper case
    inputBinding:
      position: 101
      prefix: --upper-case
  - id: urlesc
    type:
      - 'null'
      - boolean
    doc: URL-encode filenames
    inputBinding:
      position: 101
      prefix: --urlesc
  - id: use_module
    type:
      - 'null'
      - string
    doc: use specified module
    inputBinding:
      position: 101
      prefix: --use
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: renamed_files
    type:
      type: array
      items: File
    doc: Files in the working directory after the rename
    outputBinding:
      glob: '*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rename:1.601--0
stdout: rename.out
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.files)
        writable: true
