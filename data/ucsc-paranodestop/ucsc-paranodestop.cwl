cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStop
label: ucsc-paranodestop
doc: "A tool from the UCSC Genome Browser utilities used to stop a node in a paraHub/paraNode
  cluster. Note: The provided help text contains only container runtime error logs
  and does not list specific arguments.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranodestop:482--h0b57e2e_0
stdout: ucsc-paranodestop.out
