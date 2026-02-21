cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedSort
label: ucsc-bedremoveoverlap_bedSort
doc: "Sorts a BED file. The input and output can be the same file.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: The input BED file to be sorted.
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: The output sorted BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedremoveoverlap:482--h0b57e2e_0
