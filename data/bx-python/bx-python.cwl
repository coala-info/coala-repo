cwlVersion: v1.2
class: CommandLineTool
baseCommand: bx-python
label: bx-python
doc: "The provided text contains system error messages (disk space exhaustion) rather
  than tool help text. No command-line arguments or descriptions could be extracted.\n\
  \nTool homepage: https://github.com/bxlab/bx-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bx-python:0.14.0--py312h5e9d817_0
stdout: bx-python.out
