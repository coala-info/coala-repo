cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmseq
label: cmseq
doc: "A tool for consensus sequence and polymorphism analysis from microbial sequencing
  data (Note: The provided text contains system error logs rather than help documentation).\n
  \nTool homepage: https://github.com/SegataLab/cmseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmseq:1.0.4--pyhb7b1952_0
stdout: cmseq.out
