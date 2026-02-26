cwlVersion: v1.2
class: CommandLineTool
baseCommand: check-sort-order
label: check-sort-order
doc: "Check if a BAM file is sorted according to the specified genome.\n\nTool homepage:
  https://github.com/gogetdata/ggd-utils"
inputs:
  - id: path
    type: File
    doc: Path to the BAM file to check.
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: A genome file of chromosome sizes and order.
    inputBinding:
      position: 102
      prefix: --genome
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/check-sort-order:0.0.7--h9ee0642_1
stdout: check-sort-order.out
