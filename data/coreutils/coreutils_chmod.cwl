cwlVersion: v1.2
class: CommandLineTool
baseCommand: chmod
label: coreutils_chmod
doc: "Change the mode of each FILE to MODE. With --reference, change the mode of each
  FILE to that of RFILE.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode in symbolic or octal format. Required unless --reference is used.
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: Files to change the mode of
    inputBinding:
      position: 2
  - id: changes
    type:
      - 'null'
      - boolean
    doc: like verbose but report only when a change is made
    inputBinding:
      position: 103
      prefix: --changes
  - id: dereference
    type:
      - 'null'
      - boolean
    doc: affect the referent of each symbolic link, rather than the symbolic link
      itself
    inputBinding:
      position: 103
      prefix: --dereference
  - id: no_dereference
    type:
      - 'null'
      - boolean
    doc: affect each symbolic link, rather than the referent
    inputBinding:
      position: 103
      prefix: --no-dereference
  - id: no_preserve_root
    type:
      - 'null'
      - boolean
    doc: do not treat '/' specially (the default)
    inputBinding:
      position: 103
      prefix: --no-preserve-root
  - id: no_traverse_links
    type:
      - 'null'
      - boolean
    doc: do not traverse any symbolic links
    inputBinding:
      position: 103
      prefix: -P
  - id: preserve_root
    type:
      - 'null'
      - boolean
    doc: fail to operate recursively on '/'
    inputBinding:
      position: 103
      prefix: --preserve-root
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: change files and directories recursively
    inputBinding:
      position: 103
      prefix: --recursive
  - id: reference
    type:
      - 'null'
      - File
    doc: use RFILE's mode instead of specifying MODE values
    inputBinding:
      position: 103
      prefix: --reference
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress most error messages
    inputBinding:
      position: 103
      prefix: --silent
  - id: traverse_all_links
    type:
      - 'null'
      - boolean
    doc: traverse every symbolic link to a directory encountered
    inputBinding:
      position: 103
      prefix: -L
  - id: traverse_command_line_link
    type:
      - 'null'
      - boolean
    doc: if a command line argument is a symbolic link to a directory, traverse it
    inputBinding:
      position: 103
      prefix: -H
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: output a diagnostic for every file processed
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_chmod.out
