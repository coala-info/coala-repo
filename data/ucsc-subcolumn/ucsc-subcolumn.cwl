cwlVersion: v1.2
class: CommandLineTool
baseCommand: subColumn
label: ucsc-subcolumn
doc: "The provided text does not contain help information as it is an error log reporting
  a failure to build or fetch the container image. No arguments could be parsed.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-subcolumn:482--h0b57e2e_0
stdout: ucsc-subcolumn.out
