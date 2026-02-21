cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSwap
label: ucsc-chainswap
doc: "The provided text is a container runtime error log and does not contain help
  documentation. chainSwap is a UCSC tool used to swap target and query in a chain
  file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainswap:482--h0b57e2e_0
stdout: ucsc-chainswap.out
