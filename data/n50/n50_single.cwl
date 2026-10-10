cwlVersion: v1.2
class: CommandLineTool
baseCommand: n50_single
label: n50_single
doc: "Print the N50 or the total length, number of sequences and N50 of a single FASTA or FASTQ file.\n\nTool homepage: https://github.com/quadram-institute-bioscience/n50"
inputs:
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Force FASTA format"
    inputBinding:
      position: 1
      prefix: "--fasta"
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Force FASTQ format"
    inputBinding:
      position: 1
      prefix: "--fastq"
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Print a header line with the column names"
    inputBinding:
      position: 1
      prefix: "--header"
  - id: n50_only
    type:
      - 'null'
      - boolean
    doc: "Print only the N50 value"
    inputBinding:
      position: 1
      prefix: "--n50"
  - id: filename
    type:
      - 'null'
      - File
    doc: "Input FASTA or FASTQ file"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50_single.out
