cwlVersion: v1.2
class: CommandLineTool
baseCommand: ameme
label: ucsc-ameme
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container build failure (no space left on device).\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ameme:482--h0b57e2e_0
stdout: ucsc-ameme.out
