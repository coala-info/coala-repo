cwlVersion: v1.2
class: CommandLineTool
baseCommand: odil_odilia
label: odil_odilia
doc: "The provided text does not contain help information or a description of the
  tool's functionality, as it consists of system error messages related to container
  execution.\n\nTool homepage: https://github.com/odilia-app/odilia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/odil:v0.10.0-3-deb-py3_cv1
stdout: odil_odilia.out
