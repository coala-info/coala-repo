cwlVersion: v1.2
class: CommandLineTool
baseCommand: boms
label: boms
doc: "BOMS (Bacterial Oligonucleotide Meta-Statistics) is a tool for analyzing oligonucleotide
  frequencies in bacterial genomes.\n\nTool homepage: https://github.com/ocimakamboj/boms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/boms:1.1.0--py310h8ea774a_2
stdout: boms.out
