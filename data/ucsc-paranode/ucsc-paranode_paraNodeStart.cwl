cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStart
label: ucsc-paranode_paraNodeStart
doc: "UCSC paraNodeStart tool (Note: The provided help text contains only container
  runtime logs and a fatal error; no usage information or arguments were found.)\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0
stdout: ucsc-paranode_paraNodeStart.out
