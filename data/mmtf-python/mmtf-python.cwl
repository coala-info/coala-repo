cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmtf-python
label: mmtf-python
doc: "Python API for the Macromolecular Transmission Format (MMTF). Note: The provided
  help text contains system error messages regarding container image extraction and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/samirelanduk/atomium"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmtf-python:1.0.5--py34_0
stdout: mmtf-python.out
