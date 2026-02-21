cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfpl
label: deepfplearn_dfpl
doc: "DeepFPlearn (dfpl) is a tool for deep learning on molecular fingerprints. Note:
  The provided help text contains only system error messages regarding container initialization
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/yigbt/deepFPlearn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
stdout: deepfplearn_dfpl.out
