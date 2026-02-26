cwlVersion: v1.2
class: CommandLineTool
baseCommand: selene_sdk
label: selene-sdk_selene_sdk
doc: "Selene SDK command-line tool\n\nTool homepage: https://github.com/FunctionLab/selene"
inputs:
  - id: path
    type: File
    doc: Path to the configuration file or directory
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selene-sdk:0.6.0--py312h0fa9677_2
stdout: selene-sdk_selene_sdk.out
