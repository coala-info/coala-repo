cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixNormalize
label: ucsc-matrixmarkettotsv_matrixNormalize
doc: "The provided text does not contain help information for the tool, as it consists
  of container runtime log messages and a fatal error during the image build process.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixmarkettotsv:482--h0b57e2e_0
stdout: ucsc-matrixmarkettotsv_matrixNormalize.out
