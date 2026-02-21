cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainToPslBasic
label: ucsc-chaintopslbasic
doc: "Convert chain files to PSL format (basic version). Note: The provided help text
  contains only system error messages and does not list specific arguments.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintopslbasic:482--h0b57e2e_0
stdout: ucsc-chaintopslbasic.out
