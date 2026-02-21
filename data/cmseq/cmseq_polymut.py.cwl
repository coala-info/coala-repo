cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmseq_polymut.py
label: cmseq_polymut.py
doc: "A tool from the cmseq suite, likely used for polymorphism and mutation analysis
  in consensus sequences. Note: The provided help text contains only system error
  messages regarding container execution and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/SegataLab/cmseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmseq:1.0.4--pyhb7b1952_0
stdout: cmseq_polymut.py.out
