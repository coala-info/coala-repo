cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCDnaFilter
label: ucsc-axttopsl_pslCDnaFilter
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a failed container build (no space left on device).\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttopsl:482--h0b57e2e_0
stdout: ucsc-axttopsl_pslCDnaFilter.out
