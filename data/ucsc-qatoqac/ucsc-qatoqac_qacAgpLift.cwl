cwlVersion: v1.2
class: CommandLineTool
baseCommand: qacAgpLift
label: ucsc-qatoqac_qacAgpLift
doc: "The provided help text contains only container runtime error messages and does
  not include usage information or argument descriptions for the tool qacAgpLift.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qatoqac:482--h0b57e2e_0
stdout: ucsc-qatoqac_qacAgpLift.out
