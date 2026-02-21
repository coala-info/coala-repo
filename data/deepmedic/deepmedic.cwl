cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepmedic
label: deepmedic
doc: "DeepMedic is a tool for 3D segmentation of medical images, typically using deep
  learning (CNNs). Note: The provided text contains container runtime error messages
  rather than tool usage instructions.\n\nTool homepage: https://github.com/Kamnitsask/deepmedic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmedic:0.6.1--py27h24bf2e0_0
stdout: deepmedic.out
