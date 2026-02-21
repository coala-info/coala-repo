cwlVersion: v1.2
class: CommandLineTool
baseCommand: logomaker
label: logomaker
doc: "Logomaker is a Python package for generating publication-quality sequence logos.\n
  \nTool homepage: http://logomaker.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/logomaker:0.8--py_0
stdout: logomaker.out
