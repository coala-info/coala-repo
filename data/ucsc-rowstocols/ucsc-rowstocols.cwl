cwlVersion: v1.2
class: CommandLineTool
baseCommand: rowsToCols
label: ucsc-rowstocols
doc: "A UCSC utility to convert a file from rows to columns (transpose a matrix).\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-rowstocols:482--h0b57e2e_0
stdout: ucsc-rowstocols.out
