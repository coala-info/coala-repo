cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba_fq2fa
label: idba_fq2fa
doc: "Convert FASTQ files to FASTA files, with options for handling paired-end reads.\n
  \nTool homepage: https://github.com/loneknightpy/idba"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Filter out reads with 'N'
    inputBinding:
      position: 102
      prefix: --filter
  - id: merge
    type:
      - 'null'
      - boolean
    doc: If merge paired-end reads
    inputBinding:
      position: 102
      prefix: --merge
  - id: paired
    type:
      - 'null'
      - boolean
    doc: If input is paired-end reads
    inputBinding:
      position: 102
      prefix: --paired
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/idba:v1.1.3-3-deb_cv1
