cwlVersion: v1.2
class: CommandLineTool
baseCommand: chopFaLines
label: ucsc-chopfalines
doc: "Chops up lines in a fasta file to a specific length.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_fa
    type: File
    doc: Input fasta file
    inputBinding:
      position: 1
  - id: line_size
    type: int
    doc: Maximum line length
    inputBinding:
      position: 2
outputs:
  - id: out_fa
    type: File
    doc: Output fasta file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chopfalines:482--h0b57e2e_0
