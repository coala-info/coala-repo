cwlVersion: v1.2
class: CommandLineTool
baseCommand: metdatamodel
label: metdatamodel
doc: "The provided text does not contain help information or usage instructions; it
  contains system error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/shuzhao-li/metDataModel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metdatamodel:0.6.0--pyhdfd78af_0
stdout: metdatamodel.out
