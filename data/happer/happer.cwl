cwlVersion: v1.2
class: CommandLineTool
baseCommand: happer
label: happer
doc: "Happer is a tool for processing genomic data (description not available in provided
  text).\n\nTool homepage: https://github.com/bioforensics/happer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/happer:0.1.1--py_0
stdout: happer.out
