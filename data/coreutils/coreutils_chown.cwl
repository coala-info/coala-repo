cwlVersion: v1.2
class: CommandLineTool
baseCommand: chown
label: coreutils_chown
doc: "Change the owner and/or group of each FILE to OWNER and/or GROUP. With --reference,
  change the owner and group of each FILE to those of RFILE.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: owner_group
    type:
      - 'null'
      - string
    doc: 'The OWNER and/or GROUP to change to. Format: [OWNER][:[GROUP]]'
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: One or more files or directories to change ownership for
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
    doc: affect the referent of each symbolic link (this is the default), rather than
      the symbolic link itself
    inputBinding:
      position: 103
      prefix: --dereference
  - id: from
    type:
      - 'null'
      - string
    doc: change the ownership of each file only if its current owner and/or group
      match those specified here
    inputBinding:
      position: 103
      prefix: --from
  - id: no_dereference
    type:
      - 'null'
      - boolean
    doc: affect symbolic links instead of any referenced file
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
  - id: no_traverse_symlinks
    type:
      - 'null'
      - boolean
    doc: do not traverse any symbolic links (default)
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
    doc: operate on files and directories recursively
    inputBinding:
      position: 103
      prefix: --recursive
  - id: reference
    type:
      - 'null'
      - File
    doc: use RFILE's ownership rather than specifying values
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
  - id: traverse_all_symlinks
    type:
      - 'null'
      - boolean
    doc: traverse every symbolic link to a directory encountered
    inputBinding:
      position: 103
      prefix: -L
  - id: traverse_command_line_symlink
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
stdout: coreutils_chown.out
