cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSwap
label: ucsc-chainswap
doc: "Swap target and query in chain.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: out_chain
    type: string
    doc: Name of the output chain file
    inputBinding:
      position: 2
outputs:
  - id: output_chain
    type: File
    doc: Chain file with target and query swapped
    outputBinding:
      glob: $(inputs.out_chain)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainswap:482--h0b57e2e_0
