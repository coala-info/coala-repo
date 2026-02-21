cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimeo
label: mimeo
doc: "A tool for mimicking or processing data (description not provided in help text)\n
  \nTool homepage: https://github.com/Adamtaranto/mimeo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimeo:1.2.1--pyhdfd78af_0
stdout: mimeo.out
