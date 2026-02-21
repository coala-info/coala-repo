cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntcard
label: ntcard
doc: "The provided text does not contain a description of the tool as it is a system
  error message regarding a container build failure.\n\nTool homepage: https://github.com/bcgsc/ntCard"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntcard:1.2.2--pl5321h077b44d_7
stdout: ntcard.out
