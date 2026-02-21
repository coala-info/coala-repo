cwlVersion: v1.2
class: CommandLineTool
baseCommand: qaToQac
label: ucsc-qatoqac
doc: "A UCSC utility to convert .qa (Quality Assessment) files to .qac (Quality Assessment
  Compressed) format. Note: The provided help text contains only system error messages
  and does not list specific arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qatoqac:482--h0b57e2e_0
stdout: ucsc-qatoqac.out
