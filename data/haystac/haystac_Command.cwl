cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystac
label: haystac_Command
doc: "The haystac commands are:\n\nTool homepage: https://github.com/antonisdim/haystac"
inputs:
  - id: command
    type: string
    doc: 'The haystac commands are:'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the chosen command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
stdout: haystac_Command.out
