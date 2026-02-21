cwlVersion: v1.2
class: CommandLineTool
baseCommand: geco3
label: geco3
doc: "GeCo3 is a genomic data compression tool. (Note: The provided text contains
  container runtime errors and does not list specific command-line arguments.)\n\n
  Tool homepage: https://github.com/cobilab/geco3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geco3:1.0--h7b50bb2_5
stdout: geco3.out
