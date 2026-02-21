cwlVersion: v1.2
class: CommandLineTool
baseCommand: impute2
label: impute2
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure.\n
  \nTool homepage: https://github.com/johnlees/23andme-impute"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impute2:2.3.2--1
stdout: impute2.out
