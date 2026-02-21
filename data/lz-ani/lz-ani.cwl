cwlVersion: v1.2
class: CommandLineTool
baseCommand: lz-ani
label: lz-ani
doc: "Average Nucleotide Identity (ANI) calculation using Lempel-Ziv complexity.\n
  \nTool homepage: https://github.com/refresh-bio/lz-ani"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lz-ani:1.2.3--h9ee0642_0
stdout: lz-ani.out
