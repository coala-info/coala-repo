cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToBed
label: ucsc-genepredtobed
doc: "Convert genePred files to BED format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: The input genePred file.
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: The output BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtobed:482--h0b57e2e_0
