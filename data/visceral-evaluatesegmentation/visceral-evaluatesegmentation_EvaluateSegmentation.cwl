cwlVersion: v1.2
class: CommandLineTool
baseCommand: EvaluateSegmentation
label: visceral-evaluatesegmentation_EvaluateSegmentation
doc: "A tool for evaluating medical image segmentations. Note: The provided help text
  contains only system logs and error messages, so specific arguments could not be
  extracted.\n\nTool homepage: https://github.com/Visceral-Project/EvaluateSegmentation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/visceral-evaluatesegmentation:2021.03.25--h287ed61_0
stdout: visceral-evaluatesegmentation_EvaluateSegmentation.out
