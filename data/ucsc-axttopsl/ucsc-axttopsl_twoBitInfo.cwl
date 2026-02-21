cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitInfo
label: ucsc-axttopsl_twoBitInfo
doc: "The provided text does not contain help information; it contains system error
  logs indicating a failure to build or run the container (no space left on device).\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttopsl:482--h0b57e2e_0
stdout: ucsc-axttopsl_twoBitInfo.out
