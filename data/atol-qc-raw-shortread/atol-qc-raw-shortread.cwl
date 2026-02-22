cwlVersion: v1.2
class: CommandLineTool
baseCommand: atol-qc-raw-shortread
label: atol-qc-raw-shortread
doc: "Quality control for raw short-read sequencing data (Note: The provided text
  contains system error messages regarding container execution and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/TomHarrop/atol-qc-raw-shortread"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-qc-raw-shortread:0.2.1--pyhdfd78af_0
stdout: atol-qc-raw-shortread.out
