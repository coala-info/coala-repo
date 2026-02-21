cwlVersion: v1.2
class: CommandLineTool
baseCommand: gat
label: gat
doc: "Genomic Association Tester (GAT) - a tool for computing the significance of
  overlap between multiple sets of genomic intervals.\n\nTool homepage: https://github.com/AndreasHeger/gat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gat:1.3.6--py37h84994c4_0
stdout: gat.out
