cwlVersion: v1.2
class: CommandLineTool
baseCommand: outrigger
label: outrigger
doc: "Outrigger is a tool for finding and comparing alternative splicing events.\n
  \nTool homepage: https://yeolab.github.io/outrigger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/outrigger:1.1.1--py35_0
stdout: outrigger.out
