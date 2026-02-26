cwlVersion: v1.2
class: CommandLineTool
baseCommand: chmod
label: python_chmod
doc: "Change file mode bits\n\nTool homepage: https://github.com/vinta/awesome-python"
inputs:
  - id: mode
    type:
      type: array
      items: string
    doc: Octal number (bit pattern sstrwxrwxrwx) or [ugoa]{+|-|=}[rwxXst]
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: Files to change mode bits for
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
  - id: list_changed_files
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
    dockerPull: quay.io/biocontainers/python:3.13
stdout: python_chmod.out
