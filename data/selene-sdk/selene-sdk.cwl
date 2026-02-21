cwlVersion: v1.2
class: CommandLineTool
baseCommand: selene-sdk
label: selene-sdk
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container build process indicating a 'no space left on device'
  failure.\n\nTool homepage: https://github.com/FunctionLab/selene"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selene-sdk:0.6.0--py312h0fa9677_2
stdout: selene-sdk.out
