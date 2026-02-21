cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallr
label: longcallr
doc: "A tool for processing long-read sequencing data (description not provided in
  help text).\n\nTool homepage: https://github.com/huangnengCSU/longcallR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py312h67e1f27_0
stdout: longcallr.out
