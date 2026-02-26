cwlVersion: v1.2
class: CommandLineTool
baseCommand: dr-disco
label: dr-disco_after
doc: "Command-line tool for disco identification and analysis.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., 'after')
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
stdout: dr-disco_after.out
