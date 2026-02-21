cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldhggene
label: ucsc-ldhggene
doc: "The provided text contains container engine error logs and does not include
  the help documentation or usage instructions for the tool 'ucsc-ldhggene'.\n\nTool
  homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ldhggene:482--h0b57e2e_0
stdout: ucsc-ldhggene.out
