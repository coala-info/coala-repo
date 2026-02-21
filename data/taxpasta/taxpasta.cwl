cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxpasta
label: taxpasta
doc: "The provided text does not contain help information for the tool; it is a container
  engine error log.\n\nTool homepage: https://github.com/taxprofiler/taxpasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxpasta:0.7.0--pyhdfd78af_1
stdout: taxpasta.out
