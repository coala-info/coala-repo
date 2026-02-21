cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeplcretrainer
label: deeplcretrainer
doc: "A tool for retraining DeepLC models (Note: The provided help text contains only
  system error messages regarding container execution and does not list specific command-line
  arguments).\n\nTool homepage: https://github.com/RobbinBouwmeester/DeepLCRetrainer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeplcretrainer:1.0.2--pyh7e72e81_0
stdout: deeplcretrainer.out
