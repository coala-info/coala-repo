cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycodestyle
label: pycodestyle
doc: "\nTool homepage: https://github.com/PyCQA/pycodestyle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycodestyle:2.0.0--py35_0
stdout: pycodestyle.out
