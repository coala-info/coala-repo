cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmtime
label: ucsc-gmtime
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/fetch process. Based on the tool name, this
  is likely the UCSC utility to convert Unix timestamps to GMT.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gmtime:482--h0b57e2e_0
stdout: ucsc-gmtime.out
