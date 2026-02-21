cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslFilter
label: ucsc-pslfilter
doc: "The provided text does not contain help information for the tool. It contains
  container runtime log messages and a fatal error indicating a failure to fetch or
  build the image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslfilter:482--h0b57e2e_0
stdout: ucsc-pslfilter.out
