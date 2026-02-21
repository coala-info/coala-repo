cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToChain
label: ucsc-psltochain
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a series of system logs and a fatal error message regarding a container
  build failure.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltochain:482--h0b57e2e_0
stdout: ucsc-psltochain.out
