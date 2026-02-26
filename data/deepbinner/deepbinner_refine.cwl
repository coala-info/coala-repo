cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbinner refine
label: deepbinner_refine
doc: "Refine the training set\n\nTool homepage: https://github.com/rrwick/Deepbinner"
inputs:
  - id: training_data
    type: string
    doc: Balanced training data produced by the balance command
    inputBinding:
      position: 1
  - id: classification_data
    type: string
    doc: Training data barcode calls produced by the classify command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
stdout: deepbinner_refine.out
