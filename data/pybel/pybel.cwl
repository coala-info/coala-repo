cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybel
label: pybel
doc: "A Python interface to Open Babel\n\nTool homepage: https://pybel.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel.out
