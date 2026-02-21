cwlVersion: v1.2
class: CommandLineTool
baseCommand: localtime
label: ucsc-localtime
doc: "A tool to convert a 32-bit integer time (Unix timestamp) to a local time string.
  Note: The provided help text contains only container execution errors and no usage
  information.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-localtime:482--h0b57e2e_0
stdout: ucsc-localtime.out
