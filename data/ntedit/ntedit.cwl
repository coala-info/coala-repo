cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntedit
label: ntedit
doc: "The provided text does not contain help information for ntedit; it is a system
  error log indicating a failure to build a container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/bcgsc/ntEdit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntedit:2.1.1--pl5321h077b44d_0
stdout: ntedit.out
