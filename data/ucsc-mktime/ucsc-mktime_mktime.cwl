cwlVersion: v1.2
class: CommandLineTool
baseCommand: mktime
label: ucsc-mktime_mktime
doc: "convert date string to unix timestamp\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: date_time
    type: string
    doc: Date and time string in YYYY-MM-DD HH:MM:SS format
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mktime:482--h0b57e2e_0
stdout: ucsc-mktime_mktime.out
