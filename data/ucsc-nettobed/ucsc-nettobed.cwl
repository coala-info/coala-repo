cwlVersion: v1.2
class: CommandLineTool
baseCommand: netToBed
label: ucsc-nettobed
doc: "Convert net file to bed file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_net
    type: File
    doc: Input net file
    inputBinding:
      position: 1
outputs:
  - id: output_bed
    type: File
    doc: Output bed file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nettobed:482--h0b57e2e_0
