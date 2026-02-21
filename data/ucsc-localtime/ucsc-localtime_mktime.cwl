cwlVersion: v1.2
class: CommandLineTool
baseCommand: localtime_mktime
label: ucsc-localtime_mktime
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-localtime:482--h0b57e2e_0
stdout: ucsc-localtime_mktime.out
