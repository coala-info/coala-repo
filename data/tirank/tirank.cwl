cwlVersion: v1.2
class: CommandLineTool
baseCommand: tirank
label: tirank
doc: "TIRank (Tumor-Infiltrating lymphocyte Ranker)\n\nTool homepage: https://github.com/LenisLin/TiRank"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tirank:1.0.2--pyhdfd78af_1
stdout: tirank.out
