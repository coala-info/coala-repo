cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixClusterColumns
label: ucsc-matrixmarkettotsv_matrixClusterColumns
doc: "The provided text contains container execution logs and a fatal error rather
  than the tool's help documentation. As a result, no arguments could be extracted.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixmarkettotsv:482--h0b57e2e_0
stdout: ucsc-matrixmarkettotsv_matrixClusterColumns.out
