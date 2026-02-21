cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3toembl
label: gff3toembl
doc: "A tool to convert GFF3 files to EMBL format.\n\nTool homepage: https://github.com/sanger-pathogens/gff3toembl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toembl:1.1.4--py_1
stdout: gff3toembl.out
