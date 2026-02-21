cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedSort
label: ucsc-bedsort
doc: "Sort a BED file by chromosome and start position.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input BED file to be sorted.
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: The destination for the sorted BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedsort:482--h0b57e2e_0
