cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-twobitdup
label: ucsc-twobitdup
doc: "Check for duplicate sequences in a 2bit file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitdup:482--h0b57e2e_0
stdout: ucsc-twobitdup.out
