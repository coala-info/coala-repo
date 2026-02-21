cwlVersion: v1.2
class: CommandLineTool
baseCommand: mv
label: coreutils_mv
doc: "Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: source
    type:
      type: array
      items: File
    doc: Source file(s) or directory(ies) to move
    inputBinding:
      position: 1
  - id: destination
    type:
      - 'null'
      - string
    doc: Destination file or directory
    inputBinding:
      position: 2
  - id: backup
    type:
      - 'null'
      - boolean
    doc: like --backup but does not accept an argument
    inputBinding:
      position: 103
      prefix: -b
  - id: backup_control
    type:
      - 'null'
      - string
    doc: 'make a backup of each existing destination file; accepts CONTROL values:
      none, off, numbered, t, existing, nil, simple, never'
    inputBinding:
      position: 103
      prefix: --backup
  - id: context
    type:
      - 'null'
      - boolean
    doc: set SELinux security context of destination file to default type
    inputBinding:
      position: 103
      prefix: --context
  - id: debug
    type:
      - 'null'
      - boolean
    doc: explain how a file is copied. Implies -v
    inputBinding:
      position: 103
      prefix: --debug
  - id: exchange
    type:
      - 'null'
      - boolean
    doc: exchange source and destination
    inputBinding:
      position: 103
      prefix: --exchange
  - id: force
    type:
      - 'null'
      - boolean
    doc: do not prompt before overwriting
    inputBinding:
      position: 103
      prefix: --force
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: prompt before overwrite
    inputBinding:
      position: 103
      prefix: --interactive
  - id: no_clobber
    type:
      - 'null'
      - boolean
    doc: do not overwrite an existing file
    inputBinding:
      position: 103
      prefix: --no-clobber
  - id: no_copy
    type:
      - 'null'
      - boolean
    doc: do not copy if renaming fails
    inputBinding:
      position: 103
      prefix: --no-copy
  - id: no_target_directory
    type:
      - 'null'
      - boolean
    doc: treat DEST as a normal file
    inputBinding:
      position: 103
      prefix: --no-target-directory
  - id: strip_trailing_slashes
    type:
      - 'null'
      - boolean
    doc: remove any trailing slashes from each SOURCE argument
    inputBinding:
      position: 103
      prefix: --strip-trailing-slashes
  - id: suffix
    type:
      - 'null'
      - string
    doc: override the usual backup suffix
    inputBinding:
      position: 103
      prefix: --suffix
  - id: target_directory
    type:
      - 'null'
      - Directory
    doc: move all SOURCE arguments into DIRECTORY
    inputBinding:
      position: 103
      prefix: --target-directory
  - id: update_control
    type:
      - 'null'
      - string
    doc: control which existing files are updated; UPDATE={all,none,none-fail,older(default)}
    inputBinding:
      position: 103
      prefix: --update
  - id: update_older
    type:
      - 'null'
      - boolean
    doc: equivalent to --update[=older]
    inputBinding:
      position: 103
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: explain what is being done
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
stdout: coreutils_mv.out
