cwlVersion: v1.2
class: CommandLineTool
baseCommand: faTrans
label: ucsc-fatrans
doc: "Translate DNA sequences in a FASTA file to protein sequences.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input DNA FASTA file
    inputBinding:
      position: 1
outputs:
  - id: output_fasta
    type: File
    doc: Output protein FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatrans:482--h0b57e2e_0
