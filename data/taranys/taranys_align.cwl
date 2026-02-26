cwlVersion: v1.2
class: CommandLineTool
baseCommand: taranys
label: taranys_align
doc: "taranys version 3.0.1\n\nTool homepage: https://github.com/BU-ISCIII/taranys"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
stdout: taranys_align.out
