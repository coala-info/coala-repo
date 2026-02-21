cwlVersion: v1.2
class: CommandLineTool
baseCommand: wepp
label: wepp
doc: "The Water Erosion Prediction Project (WEPP) model is a process-based, distributed
  parameter, continuous simulation, erosion prediction model.\n\nTool homepage: https://github.com/TurakhiaLab/WEPP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wepp:0.1.5.1--hd668422_0
stdout: wepp.out
