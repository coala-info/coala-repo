cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlstdb
label: mlstdb
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build a container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/himal2007/mlstdb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlstdb:0.2.0--pyh7e72e81_0
stdout: mlstdb.out
