cwlVersion: v1.2
class: CommandLineTool
baseCommand: hubPublicCheck
label: ucsc-hubpubliccheck
doc: "A tool to check if a UCSC Track Hub is publicly accessible and valid. Note:
  The provided help text contained only container runtime error messages and did not
  list specific command-line arguments.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hubpubliccheck:482--h0b57e2e_0
stdout: ucsc-hubpubliccheck.out
