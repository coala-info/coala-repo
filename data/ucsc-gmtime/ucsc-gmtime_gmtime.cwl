cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmtime
label: ucsc-gmtime_gmtime
doc: "convert unix timestamp to date string\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: time_stamp
    type: int
    doc: integer 0 to 2147483647
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gmtime:482--h0b57e2e_0
stdout: ucsc-gmtime_gmtime.out
