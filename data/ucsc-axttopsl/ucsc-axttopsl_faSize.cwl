cwlVersion: v1.2
class: CommandLineTool
baseCommand: faSize
label: ucsc-axttopsl_faSize
doc: "The provided input text does not contain help documentation for the tool. It
  is a system error log indicating a failure to build or extract a container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttopsl:482--h0b57e2e_0
stdout: ucsc-axttopsl_faSize.out
