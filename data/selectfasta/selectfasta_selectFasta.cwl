cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/selectFasta
label: selectfasta_selectFasta
doc: "Select fastQ or fasta reads from list, -list or -random is required\n\nTool
  homepage: https://github.com/andvides/selectFasta/"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: fasta file to select reads from
    inputBinding:
      position: 101
      prefix: -fasta
  - id: fasta_sel
    type:
      - 'null'
      - boolean
    doc: from fasta file select reads in -list, if not flag, reads not in list are
      selected
    inputBinding:
      position: 101
      prefix: -fasta_sel
  - id: fastq
    type:
      - 'null'
      - File
    doc: fastq file to select reads from
    inputBinding:
      position: 101
      prefix: -fastq
  - id: fastq2fasta
    type:
      - 'null'
      - boolean
    doc: convert fastq file to fasta
    inputBinding:
      position: 101
      prefix: -fastq2fasta
  - id: list
    type:
      - 'null'
      - File
    doc: list of reads, fastq or fasta
    inputBinding:
      position: 101
      prefix: -list
  - id: random
    type:
      - 'null'
      - int
    doc: number of random reads to be selected from fasta/fastq file
    inputBinding:
      position: 101
      prefix: -random
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selectfasta:3.1--h503566f_1
stdout: selectfasta_selectFasta.out
