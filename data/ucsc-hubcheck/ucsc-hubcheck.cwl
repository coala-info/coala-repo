cwlVersion: v1.2
class: CommandLineTool
baseCommand: hubCheck
label: ucsc-hubcheck
doc: "Check a track hub for errors.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hubcheck:482--h0b57e2e_0
stdout: ucsc-hubcheck.out
