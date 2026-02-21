cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafFilter
label: ucsc-maftosnpbed_mafFilter
doc: "The provided help text contains container engine logs and a fatal error message
  rather than tool-specific usage information. No arguments could be extracted.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftosnpbed:482--h0b57e2e_0
stdout: ucsc-maftosnpbed_mafFilter.out
