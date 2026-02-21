cwlVersion: v1.2
class: CommandLineTool
baseCommand: readfq
label: readfq
doc: "A fasta/fastq parser tool. Note: The provided help text contains only container
  build errors and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/billzt/readfq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/readfq:2015.08.30--h577a1d6_7
stdout: readfq.out
