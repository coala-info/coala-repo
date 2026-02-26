cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastool
label: fastool
doc: "Convert FASTQ to FASTA and perform other operations.\n\nTool homepage: https://github.com/tobe-fe-dalao/fastool"
inputs:
  - id: sequences_1
    type: File
    doc: First input FASTQ/A file.
    inputBinding:
      position: 1
  - id: sequences_2
    type:
      type: array
      items: File
    doc: Second input FASTQ/A file (optional, can be multiple).
    inputBinding:
      position: 2
  - id: append
    type:
      - 'null'
      - string
    doc: String to append to the header.
    inputBinding:
      position: 103
      prefix: --append
  - id: illumina_trinity
    type:
      - 'null'
      - boolean
    doc: Format sequences for Illumina Trinity.
    inputBinding:
      position: 103
      prefix: --illumina-trinity
  - id: rev
    type:
      - 'null'
      - boolean
    doc: Reverse complement the sequences.
    inputBinding:
      position: 103
      prefix: --rev
  - id: to_fasta
    type:
      - 'null'
      - boolean
    doc: Convert sequences to FASTA format.
    inputBinding:
      position: 103
      prefix: --to-fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastool:0.1.4--h577a1d6_10
stdout: fastool.out
