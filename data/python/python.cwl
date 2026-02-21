cwlVersion: v1.2
class: CommandLineTool
baseCommand: python
label: python
doc: "Python is an interpreted, interactive, object-oriented programming language.\n
  \nTool homepage: https://github.com/vinta/awesome-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/python:3.13
stdout: python.out
