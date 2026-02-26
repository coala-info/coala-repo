cwlVersion: v1.2
class: CommandLineTool
baseCommand: moca
label: moca
doc: "Try \"moca --help\" for help.\n\nTool homepage: https://github.com/saketkc/moca"
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
    dockerPull: quay.io/biocontainers/moca:0.4.3--py27_0
stdout: moca.out
