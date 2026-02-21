cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosplit
label: nanosplit
doc: "A tool for splitting Oxford Nanopore sequencing data (typically FASTQ files).
  Note: The provided help text contains only system error messages and does not list
  specific arguments.\n\nTool homepage: https://github.com/wdecoster/nanosplit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosplit:0.1.4--py35_0
stdout: nanosplit.out
