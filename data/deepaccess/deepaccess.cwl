cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepaccess
label: deepaccess
doc: "DeepAccess is a tool for predicting cell-type specific epigenetic accessibility
  from DNA sequence.\n\nTool homepage: https://github.com/gifford-lab/deepaccess-package"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepaccess:0.1.3--pyhdfd78af_0
stdout: deepaccess.out
