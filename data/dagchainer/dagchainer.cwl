cwlVersion: v1.2
class: CommandLineTool
baseCommand: dagchainer
label: dagchainer
doc: "The provided text does not contain help information or usage instructions for
  dagchainer; it is a system error log indicating a failure to build a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/kullrich/dagchainer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dagchainer:r120920--h9948957_5
stdout: dagchainer.out
