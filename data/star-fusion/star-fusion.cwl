cwlVersion: v1.2
class: CommandLineTool
baseCommand: STAR-Fusion
label: star-fusion
doc: "STAR-Fusion is a tool for detecting fusion genes from RNA-seq data.\n\nTool
  homepage: https://github.com/STAR-Fusion/STAR-Fusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/star-fusion:1.15.1--hdfd78af_1
stdout: star-fusion.out
