cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkdir
label: duphist
doc: "Create DIRECTORY\n\nTool homepage: https://github.com/minjeongjj/DupHIST"
inputs:
  - id: directories
    type:
      type: array
      items: Directory
    doc: Directories to create
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
    dockerPull: quay.io/biocontainers/duphist:1.1.0--hdfd78af_1
stdout: duphist.out
