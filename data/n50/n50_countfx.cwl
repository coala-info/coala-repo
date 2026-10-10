cwlVersion: v1.2
class: CommandLineTool
baseCommand: countfx
label: n50_countfx
doc: "Count the sequences of a FASTA or FASTQ file.\n\nTool homepage: https://github.com/quadram-institute-bioscience/n50"
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
  - id: file
    type: File
    doc: "Input file (.fq, .fq.gz, .fastq, .fastq.gz are read as FASTQ, everything else as FASTA)"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50_countfx.out
