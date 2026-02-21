cwlVersion: v1.2
class: CommandLineTool
baseCommand: tssar
label: tssar
doc: "TSSAR (TSS Annotation from RNA-seq) is a tool for the identification of transcription
  start sites (TSS) from comparative RNA-seq data.\n\nTool homepage: https://github.com/tssarker/tssarker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tssar:1.0.1--r44h7b50bb2_10
stdout: tssar.out
