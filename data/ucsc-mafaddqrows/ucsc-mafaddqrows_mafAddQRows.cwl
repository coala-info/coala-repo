cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafAddQRows
label: ucsc-mafaddqrows_mafAddQRows
doc: "Add quality scores to a MAF file. (Note: The provided help text contains a container
  runtime error and does not list specific arguments.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafaddqrows:482--h0b57e2e_0
stdout: ucsc-mafaddqrows_mafAddQRows.out
