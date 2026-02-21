cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafFrags
label: ucsc-maffrags
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container build failure. No arguments
  or tool descriptions could be extracted from the input.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maffrags:482--h0b57e2e_0
stdout: ucsc-maffrags.out
