cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkdir
label: blinker_mkdir
doc: "Create DIRECTORY\n\nTool homepage: https://github.com/blinksh/blink"
inputs:
  - id: directories
    type:
      type: array
      items: Directory
    doc: Directory to create
    inputBinding:
      position: 1
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode
    inputBinding:
      position: 102
      prefix: -m
  - id: parents
    type:
      - 'null'
      - boolean
    doc: No error if exists; make parent directories as needed
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blinker:1.4--py35_0
stdout: blinker_mkdir.out
