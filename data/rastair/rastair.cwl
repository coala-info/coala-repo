cwlVersion: v1.2
class: CommandLineTool
baseCommand: rastair
label: rastair
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rastair:0.8.2--r44h4349ce8_2
stdout: rastair.out
