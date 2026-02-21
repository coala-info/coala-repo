cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainPreNet
label: ucsc-chainprenet
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains container environment logs and a fatal error message regarding
  image retrieval.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainprenet:482--h0b57e2e_0
stdout: ucsc-chainprenet.out
