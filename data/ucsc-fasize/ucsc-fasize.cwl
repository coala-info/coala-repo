cwlVersion: v1.2
class: CommandLineTool
baseCommand: faSize
label: ucsc-fasize
doc: "Compute length and composition of sequences in a FASTA file.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: Print out size of each record
    inputBinding:
      position: 102
      prefix: -detailed
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Print out in tab-separated format
    inputBinding:
      position: 102
      prefix: -tab
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fasize:482--h0b57e2e_0
stdout: ucsc-fasize.out
