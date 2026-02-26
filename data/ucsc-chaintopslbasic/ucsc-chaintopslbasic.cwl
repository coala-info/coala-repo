cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainToPslBasic
label: ucsc-chaintopslbasic
doc: "Convert a chain file to a PSL file (basic version).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
outputs:
  - id: output_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintopslbasic:482--h0b57e2e_0
