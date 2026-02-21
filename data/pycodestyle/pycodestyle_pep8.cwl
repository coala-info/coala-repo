cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycodestyle
label: pycodestyle_pep8
doc: "pycodestyle (formerly pep8) is a tool to check your Python code against some
  of the style conventions in PEP 8.\n\nTool homepage: https://github.com/PyCQA/pycodestyle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycodestyle:2.0.0--py35_0
stdout: pycodestyle_pep8.out
