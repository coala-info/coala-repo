cwlVersion: v1.2
class: CommandLineTool
baseCommand: TeloSearchLR.py
label: telosearchlr_TeloSearchLR.py
doc: "TeloSearchLR is a tool for identifying telomeric repeats in long-read sequencing
  data.\n\nTool homepage: https://github.com/gchchung/TeloSearchLR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telosearchlr:1.0.1--pyhdfd78af_0
stdout: telosearchlr_TeloSearchLR.py.out
