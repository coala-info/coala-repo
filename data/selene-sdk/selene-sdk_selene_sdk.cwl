cwlVersion: v1.2
class: CommandLineTool
baseCommand: selene_sdk
label: selene-sdk_selene_sdk
doc: "Selene is a framework for developing sequence-level deep learning models. (Note:
  The provided help text contains only system error logs and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/FunctionLab/selene"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selene-sdk:0.6.0--py312h0fa9677_2
stdout: selene-sdk_selene_sdk.out
