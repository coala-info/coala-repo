cwlVersion: v1.2
class: CommandLineTool
baseCommand: mentalist
label: mentalist_FASTA
doc: "A command-line tool for analyzing microbial genomic data.\n\nTool homepage:
  https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
stdout: mentalist_FASTA.out
