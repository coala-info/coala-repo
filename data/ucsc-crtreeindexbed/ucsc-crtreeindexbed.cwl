cwlVersion: v1.2
class: CommandLineTool
baseCommand: crTreeIndexBed
label: ucsc-crtreeindexbed
doc: "Index a BED file into a chromosome range tree (crTree).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bed
    type: File
    doc: Input BED file to be indexed.
    inputBinding:
      position: 1
outputs:
  - id: output_cr
    type: File
    doc: Output crTree index file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-crtreeindexbed:482--h0b57e2e_0
