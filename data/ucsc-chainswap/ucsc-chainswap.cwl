cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSwap
label: ucsc-chainswap
doc: "Swap target and query in a chain file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainswap:482--h0b57e2e_0
