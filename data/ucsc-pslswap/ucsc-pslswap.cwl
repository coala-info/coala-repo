cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSwap
label: ucsc-pslswap
doc: "The provided text does not contain help information as it is a container runtime
  error log. Based on the tool name, this utility is used to swap target and query
  sequences in PSL (Pattern Space Layout) files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslswap:482--h0b57e2e_0
stdout: ucsc-pslswap.out
