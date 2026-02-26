cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToTab
label: ucsc-fatotab
doc: "Convert DNA FASTA file to a 2 column tab-separated file (name and sequence).\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: keep_case
    type:
      - 'null'
      - boolean
    doc: Keep case of DNA
    inputBinding:
      position: 102
      prefix: -keepCase
  - id: length
    type:
      - 'null'
      - boolean
    doc: Output length of sequence instead of sequence
    inputBinding:
      position: 102
      prefix: -length
  - id: type
    type:
      - 'null'
      - string
    doc: Specify type (dna, rna, protein)
    inputBinding:
      position: 102
      prefix: -type
outputs:
  - id: output_tab
    type: File
    doc: Output tab-separated file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatotab:482--h0b57e2e_0
