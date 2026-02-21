cwlVersion: v1.2
class: CommandLineTool
baseCommand: netClass
label: ucsc-netclass
doc: "The provided text contains container execution logs and error messages rather
  than the command-line help documentation for ucsc-netclass. As a result, no arguments
  or tool descriptions could be extracted from the input.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netclass:482--h0b57e2e_0
stdout: ucsc-netclass.out
