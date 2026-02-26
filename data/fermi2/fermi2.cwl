cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2
label: fermi2
doc: "fermi2 is a tool for sequence assembly and analysis.\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., diff, occflt, sub, unpack, correct, 
      count, interleave, assemble, simplify, sa, match)
    inputBinding:
      position: 1
  - id: arguments
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
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2.out
