cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-anonymous
label: fastq-anonymous
doc: "Change the sequence of a fastq file to enable sharing of confidential information,
  for troubleshooting of tools.\n\nTool homepage: https://github.com/wdecoster/fastq-anonymous"
inputs:
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Mask all nucleotides using N
    inputBinding:
      position: 101
      prefix: --mask
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-anonymous:1.0.1--py36_0
stdout: fastq-anonymous.out
