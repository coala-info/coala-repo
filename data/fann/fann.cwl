cwlVersion: v1.2
class: CommandLineTool
baseCommand: fann
label: fann
doc: "Fast Artificial Neural Network (FANN) library tool. Note: The provided help
  text contains only system error messages regarding container image creation and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/libfann/fann"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fann:2.2.0--0
stdout: fann.out
