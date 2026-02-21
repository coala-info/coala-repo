cwlVersion: v1.2
class: CommandLineTool
baseCommand: shannon_cpp
label: shannon_cpp
doc: "The provided text does not contain help information or usage instructions for
  shannon_cpp. It contains system error logs related to a failed container image build
  (no space left on device).\n\nTool homepage: https://github.com/bx3/shannon_cpp.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shannon:0.0.2--py_0
stdout: shannon_cpp.out
