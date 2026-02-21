cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafRanges
label: ucsc-mafranges
doc: "The provided text does not contain help information for the tool. It contains
  log messages and a fatal error related to a container build process.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafranges:482--h0b57e2e_0
stdout: ucsc-mafranges.out
