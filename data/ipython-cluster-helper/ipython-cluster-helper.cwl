cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipython-cluster-helper
label: ipython-cluster-helper
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/roryk/ipython-cluster-helper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipython-cluster-helper:0.6.4--py_0
stdout: ipython-cluster-helper.out
