cwlVersion: v1.2
class: CommandLineTool
baseCommand: tickToDate
label: ucsc-ticktodate_tickToDate
doc: "Converts a 32-bit Unix timestamp (ticks) to a human-readable date string.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: tick
    type: int
    doc: The Unix timestamp (seconds since Jan 1, 1970) to convert.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ticktodate:482--h0b57e2e_0
stdout: ucsc-ticktodate_tickToDate.out
