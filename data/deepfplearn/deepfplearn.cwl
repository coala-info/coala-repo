cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepfplearn
label: deepfplearn
doc: "Deep learning for fingerprint prediction and molecular property prediction.\n
  \nTool homepage: https://github.com/yigbt/deepFPlearn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
stdout: deepfplearn.out
