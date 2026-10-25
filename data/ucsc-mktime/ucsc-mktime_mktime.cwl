cwlVersion: v1.2
class: CommandLineTool
baseCommand: mktime
label: ucsc-mktime_mktime
doc: "convert date string to unix timestamp. Valid dates: 1970-01-01 00:00:00 to 2038-01-19\
  \ 03:14:07\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: date
    type: string
    doc: Date in YYYY-MM-DD format
    inputBinding:
      position: 1
  - id: time
    type: string
    doc: Time in HH:MM:SS format
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mktime:482--h0b57e2e_0
stdout: ucsc-mktime_mktime.out
