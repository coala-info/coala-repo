cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafRanges
label: ucsc-mafranges
doc: "Convert MAF file to BED file showing ranges covered.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_maf
    type: File
    doc: Input MAF file
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
    dockerPull: quay.io/biocontainers/ucsc-mafranges:482--h0b57e2e_0
