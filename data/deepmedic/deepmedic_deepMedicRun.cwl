cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepMedicRun
label: deepmedic_deepMedicRun
doc: "DeepMedic: a tool for 3D segmentation of medical images. (Note: The provided
  input text contains system error messages regarding container image building and
  does not list specific command-line arguments.)\n\nTool homepage: https://github.com/Kamnitsask/deepmedic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmedic:0.6.1--py27h24bf2e0_0
stdout: deepmedic_deepMedicRun.out
