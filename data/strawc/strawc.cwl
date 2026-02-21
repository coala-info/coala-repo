cwlVersion: v1.2
class: CommandLineTool
baseCommand: strawc
label: strawc
doc: "A tool for fast streaming of Hi-C contact matrices.\n\nTool homepage: https://github.com/aidenlab/straw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strawc:0.0.2.1--py312h7de72ed_6
stdout: strawc.out
