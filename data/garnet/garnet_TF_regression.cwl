cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnet_TF_regression
label: garnet_TF_regression
doc: "A tool for transcription factor regression analysis (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/fraenkel-lab/GarNet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnet:0.4.5--py35_0
stdout: garnet_TF_regression.out
