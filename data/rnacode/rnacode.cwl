cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnacode
label: rnacode
doc: "RNAcode predicts protein coding regions in multiple sequence alignments. It
  uses a statistical model to distinguish between coding and non-coding evolutionary
  patterns.\n\nTool homepage: https://github.com/ViennaRNA/RNAcode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnacode:0.3.1--h7b50bb2_0
stdout: rnacode.out
