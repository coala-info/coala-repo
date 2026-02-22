cwlVersion: v1.2
class: CommandLineTool
baseCommand: blacksheep-outliers
label: blacksheep-outliers
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a container execution failure (no space
  left on device).\n\nTool homepage: https://github.com/ruggleslab/blackSheep/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blacksheep-outliers:0.0.8--py_0
stdout: blacksheep-outliers.out
