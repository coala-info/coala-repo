cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastool
label: fastool
doc: "A simple and quick tool to read huge FastQ and FastA files (both normal and gzipped) and manipulate them: convert FastQ to FastA, reverse complement, append a string to the headers, or convert Casava 1.8+ IDs to Trinity format.\n\nTool homepage: https://github.com/fstrozzi/Fastool"
inputs:
  - id: rev
    type:
      - 'null'
      - boolean
    doc: Reverse complement all the sequences in the dataset (both FastQ and FastA).
    inputBinding:
      position: 1
      prefix: --rev
  - id: append
    type:
      - 'null'
      - string
    doc: Add a string at the end of each sequence header (both FastQ and FastA).
    inputBinding:
      position: 2
      prefix: --append
  - id: to_fasta
    type:
      - 'null'
      - boolean
    doc: Convert FastQ files to FastA format.
    inputBinding:
      position: 3
      prefix: --to-fasta
  - id: illumina_trinity
    type:
      - 'null'
      - boolean
    doc: Directly convert Casava 1.8+ FastQ ID format to Trinity Fasta input format (appending /1 and /2 for PE reads).
    inputBinding:
      position: 4
      prefix: --illumina-trinity
  - id: sequences
    type:
      type: array
      items: File
    doc: Input FastQ/FastA files (plain or gzipped); several files are processed in turn.
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastool:0.1.4--h577a1d6_10
stdout: fastool.out
