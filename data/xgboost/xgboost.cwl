cwlVersion: v1.2
class: CommandLineTool
baseCommand: xgboost
label: xgboost
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a log of a failed container build or image retrieval process.\n
  \nTool homepage: https://github.com/dmlc/xgboost"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xgboost:0.6a2--py36_0
stdout: xgboost.out
