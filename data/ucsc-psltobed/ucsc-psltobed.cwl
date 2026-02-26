cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToBed
label: ucsc-psltobed
doc: "Converts PSL format (protein or DNA alignments) to BED format.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_psl
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
outputs:
  - id: output_bed
    type: File
    doc: Output BED file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltobed:482--h0b57e2e_0
