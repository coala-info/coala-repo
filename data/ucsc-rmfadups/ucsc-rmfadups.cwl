cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmFaDups
label: ucsc-rmfadups
doc: "Remove duplicate sequences from a FASTA file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file with duplicates removed
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-rmfadups:482--h0b57e2e_0
