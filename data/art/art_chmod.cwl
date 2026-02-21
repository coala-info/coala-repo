cwlVersion: v1.2
class: CommandLineTool
baseCommand: chmod
label: art_chmod
doc: "Change file mode bits (BusyBox version). MODE is octal number or [ugoa]{+|-|=}[rwxXst].\n
  \nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: mode
    type: string
    doc: Octal number (bit pattern sstrwxrwxrwx) or [ugoa]{+|-|=}[rwxXst]
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: Files or directories to change mode for
    inputBinding:
      position: 2
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
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recurse
    inputBinding:
      position: 103
      prefix: -R
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
stdout: art_chmod.out
