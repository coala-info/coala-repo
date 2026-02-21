cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepmedic_plotTrainingProgress.py
label: deepmedic_plotTrainingProgress.py
doc: "Plot training progress for DeepMedic. (Note: The provided help text contains
  system error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/Kamnitsask/deepmedic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmedic:0.6.1--py27h24bf2e0_0
stdout: deepmedic_plotTrainingProgress.py.out
