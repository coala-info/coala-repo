cwlVersion: v1.2
class: CommandLineTool
baseCommand: vitessce-python
label: vitessce-python
doc: "The provided text is a container build log and does not contain help information
  or usage instructions for the vitessce-python tool.\n\nTool homepage: https://vitessce.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vitessce-python:3.7.9--pyhdfd78af_0
stdout: vitessce-python.out
