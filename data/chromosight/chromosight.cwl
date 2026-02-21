cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosight
label: chromosight
doc: "Chromosight is a tool for detecting and quantifying patterns in Hi-C contact
  maps using computer vision.\n\nTool homepage: https://github.com/koszullab/chromosight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
stdout: chromosight.out
