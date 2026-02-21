cwlVersion: v1.2
class: CommandLineTool
baseCommand: vkmz
label: vkmz
doc: "The provided text appears to be a container execution or build log rather than
  command-line help text. As a result, no specific arguments, flags, or descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/HegemanLab/VKMZ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vkmz:1.4.6--py_0
stdout: vkmz.out
