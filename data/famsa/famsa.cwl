cwlVersion: v1.2
class: CommandLineTool
baseCommand: famsa
label: famsa
doc: "FAMSA is a tool for fast and accurate multiple sequence alignment of large sets
  of sequences.\n\nTool homepage: https://github.com/refresh-bio/FAMSA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famsa:2.4.1--h9ee0642_0
stdout: famsa.out
