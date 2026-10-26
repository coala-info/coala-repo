cwlVersion: v1.2
class: CommandLineTool
baseCommand: tickToDate
label: ucsc-ticktodate_tickToDate
doc: "Convert seconds since 1970 to time and date.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: tick
    type: string
    doc: Seconds since 1970 to convert; use 'now' for the current ticks and date.
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
