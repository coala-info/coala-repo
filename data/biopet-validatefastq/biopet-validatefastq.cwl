cwlVersion: v1.2
class: CommandLineTool
baseCommand: ValidateFastq
label: biopet-validatefastq
doc: "A tool to validate FASTQ files, supporting both single-end and paired-end data.\n
  \nTool homepage: https://github.com/biopet/validatefastq"
inputs:
  - id: fastq1
    type: File
    doc: FASTQ file to be validated.
    inputBinding:
      position: 101
      prefix: --fastq1
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Second FASTQ to be validated if FASTQs are paired.
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-validatefastq:0.1.1--1
stdout: biopet-validatefastq.out
