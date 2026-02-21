cwlVersion: v1.2
class: CommandLineTool
baseCommand: zorro
label: zorro
doc: "ZORRO is a tool for probabilistic masking of multiple sequence alignments.\n
  \nTool homepage: https://sourceforge.net/projects/probmask/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zorro:2011.12.01--h7b50bb2_5
stdout: zorro.out
