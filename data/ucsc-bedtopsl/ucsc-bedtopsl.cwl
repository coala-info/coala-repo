cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedToPsl
label: ucsc-bedtopsl
doc: "The provided text does not contain help information as it is a container runtime
  error log (no space left on device). Based on the tool name, this utility converts
  BED format files to PSL format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtopsl:482--h0b57e2e_0
stdout: ucsc-bedtopsl.out
