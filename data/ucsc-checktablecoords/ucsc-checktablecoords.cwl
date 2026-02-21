cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-checktablecoords
label: ucsc-checktablecoords
doc: "A tool to check table coordinates. Note: The provided help text contains container
  runtime error messages and does not list specific usage instructions or arguments.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-checktablecoords:482--h0b57e2e_0
stdout: ucsc-checktablecoords.out
