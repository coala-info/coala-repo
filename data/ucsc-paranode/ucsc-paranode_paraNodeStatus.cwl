cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStatus
label: ucsc-paranode_paraNodeStatus
doc: "A tool from the UCSC paraNode suite, likely used to check the status of nodes
  in a parallel processing environment. Note: The provided help text contains only
  container execution errors and no usage information.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0
stdout: ucsc-paranode_paraNodeStatus.out
