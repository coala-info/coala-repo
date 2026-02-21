cwlVersion: v1.2
class: CommandLineTool
baseCommand: faFilter
label: ucsc-fafiltern
doc: "Filter DNA sequences in a FASTA file. Note: The provided help text contains
  a container execution error and does not list specific arguments.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fafiltern:482--h0b57e2e_0
stdout: ucsc-fafiltern.out
