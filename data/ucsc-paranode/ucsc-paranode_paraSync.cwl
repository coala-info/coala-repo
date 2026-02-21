cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraSync
label: ucsc-paranode_paraSync
doc: "A tool from the ucsc-paranode package. (Note: The provided help text contains
  container execution errors and does not list usage or arguments.)\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0
stdout: ucsc-paranode_paraSync.out
