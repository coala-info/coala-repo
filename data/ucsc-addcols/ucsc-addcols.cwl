cwlVersion: v1.2
class: CommandLineTool
baseCommand: addCols
label: ucsc-addcols
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container build failure ('no space left on device').\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-addcols:482--h0b57e2e_0
stdout: ucsc-addcols.out
