cwlVersion: v1.2
class: CommandLineTool
baseCommand: fadapa
label: fadapa
doc: "A Python tool for parsing FastQC output data (Note: The provided help text contains
  only system error logs and does not list specific arguments).\n\nTool homepage:
  https://github.com/ChillarAnand/fadapa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fadapa:0.3.1--pyh864c0ab_2
stdout: fadapa.out
