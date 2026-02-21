cwlVersion: v1.2
class: CommandLineTool
baseCommand: chown
label: art_chown
doc: "Change the owner and/or group of FILEs to USER and/or GRP\n\nTool homepage:
  https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: user_group
    type: string
    doc: USER and/or GRP to change ownership to
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: FILEs to change ownership of
    inputBinding:
      position: 2
  - id: affect_symlinks
    type:
      - 'null'
      - boolean
    doc: Affect symlinks instead of symlink targets
    inputBinding:
      position: 103
      prefix: -h
  - id: hide_errors
    type:
      - 'null'
      - boolean
    doc: Hide errors
    inputBinding:
      position: 103
      prefix: -f
  - id: list_changed
    type:
      - 'null'
      - boolean
    doc: List changed files
    inputBinding:
      position: 103
      prefix: -c
  - id: no_traverse_symlinks
    type:
      - 'null'
      - boolean
    doc: Don't traverse symlinks (default)
    inputBinding:
      position: 103
      prefix: -P
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: Recurse
    inputBinding:
      position: 103
      prefix: -R
  - id: traverse_all_symlinks
    type:
      - 'null'
      - boolean
    doc: Traverse all symlinks to directories
    inputBinding:
      position: 103
      prefix: -L
  - id: traverse_command_line_symlinks
    type:
      - 'null'
      - boolean
    doc: Traverse symlinks on command line only
    inputBinding:
      position: 103
      prefix: -H
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_chown.out
