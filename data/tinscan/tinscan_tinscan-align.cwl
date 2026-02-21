cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinscan-align
label: tinscan_tinscan-align
doc: "A tool for tumor-in-normal contamination detection and analysis.\n\nTool homepage:
  https://github.com/Adamtaranto/TE-insertion-scanner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
stdout: tinscan_tinscan-align.out
