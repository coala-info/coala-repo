cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedSort
label: ucsc-bedtopsl_bedSort
doc: "Sort a BED file. The input and output can be the same file.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input BED file to be sorted.
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Output sorted BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtopsl:482--h0b57e2e_0
