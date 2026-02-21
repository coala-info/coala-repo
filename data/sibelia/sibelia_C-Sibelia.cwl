cwlVersion: v1.2
class: CommandLineTool
baseCommand: Sibelia
label: sibelia_C-Sibelia
doc: "Sibelia is a comparative genomics tool (Note: The provided text is a container
  engine error log and does not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/bioinf/Sibelia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sibelia:3.0.7--0
stdout: sibelia_C-Sibelia.out
