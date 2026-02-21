cwlVersion: v1.2
class: CommandLineTool
baseCommand: lavToAxt
label: ucsc-lavtoaxt
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log. Based on the tool name, this utility is typically
  used to convert LAV alignment files to AXT format.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-lavtoaxt:482--h0b57e2e_0
stdout: ucsc-lavtoaxt.out
