cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3_to_embl
label: gff3toembl_gff3_to_embl
doc: "A tool to convert GFF3 files to EMBL format. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/sanger-pathogens/gff3toembl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toembl:1.1.4--py_1
stdout: gff3toembl_gff3_to_embl.out
