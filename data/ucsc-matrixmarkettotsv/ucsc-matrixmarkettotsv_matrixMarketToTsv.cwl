cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixMarketToTsv
label: ucsc-matrixmarkettotsv_matrixMarketToTsv
doc: "Convert Matrix Market format to TSV. (Note: The provided help text contains
  only system error messages and no usage information; arguments could not be extracted.)\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixmarkettotsv:482--h0b57e2e_0
stdout: ucsc-matrixmarkettotsv_matrixMarketToTsv.out
