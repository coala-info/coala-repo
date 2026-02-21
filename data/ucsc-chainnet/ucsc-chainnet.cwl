cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainNet
label: ucsc-chainnet
doc: "Make nets out of chains. This tool processes alignment chains to create a hierarchical
  'net' structure representing the best orthologous alignments.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainnet:482--h0b57e2e_0
stdout: ucsc-chainnet.out
