cwlVersion: v1.2
class: CommandLineTool
baseCommand: parasail-python
label: parasail-python
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding insufficient disk space during a container image
  pull.\n\nTool homepage: https://github.com/jeffdaily/parasail-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parasail-python:1.3.4--py310h5140242_5
stdout: parasail-python.out
