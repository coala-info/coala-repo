cwlVersion: v1.2
class: CommandLineTool
baseCommand: shannon_shannon.py
label: shannon_shannon.py
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container image build failure (no space left
  on device).\n\nTool homepage: http://sreeramkannan.github.io/Shannon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shannon:0.0.2--py_0
stdout: shannon_shannon.py.out
