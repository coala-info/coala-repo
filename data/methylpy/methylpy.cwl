cwlVersion: v1.2
class: CommandLineTool
baseCommand: methylpy
label: methylpy
doc: "The provided text does not contain help information for methylpy; it contains
  system error messages regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/yupenghe/methylpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
stdout: methylpy.out
