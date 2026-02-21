cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixClusterColumns
label: ucsc-matrixclustercolumns
doc: "A tool from the UCSC Genome Browser toolset, likely used for clustering columns
  in a matrix. Note: The provided help text contains only container execution errors
  and does not list specific arguments or usage instructions.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixclustercolumns:482--h0b57e2e_0
stdout: ucsc-matrixclustercolumns.out
