cwlVersion: v1.2
class: CommandLineTool
baseCommand: localtime
label: ucsc-localtime
doc: "Converts a Unix timestamp (seconds since Jan 1, 1970) to a human-readable local
  time format.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: timestamp
    type: int
    doc: The Unix timestamp (seconds since epoch) to convert.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-localtime:482--h0b57e2e_0
stdout: ucsc-localtime.out
