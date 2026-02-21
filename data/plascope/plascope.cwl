cwlVersion: v1.2
class: CommandLineTool
baseCommand: plascope
label: plascope
doc: "The provided text does not contain help information for the tool. It is a log
  of a container build failure due to insufficient disk space.\n\nTool homepage: https://github.com/GuilhemRoyer/PlaScope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plascope:1.3.1--1
stdout: plascope.out
