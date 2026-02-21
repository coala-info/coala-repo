cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedSort
label: ucsc-bedclip_bedSort
doc: "Sort a BED file. The input and output can be the same file.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bed
    type: File
    doc: The input BED file to be sorted.
    inputBinding:
      position: 1
outputs:
  - id: out_bed
    type: File
    doc: The output sorted BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedclip:482--h0b57e2e_0
