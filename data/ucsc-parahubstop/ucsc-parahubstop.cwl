cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraHubStop
label: ucsc-parahubstop
doc: "A tool to stop a ParaHub cluster (Note: The provided text contained container
  build errors rather than help documentation).\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahubstop:482--h0b57e2e_0
stdout: ucsc-parahubstop.out
