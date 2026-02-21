cwlVersion: v1.2
class: CommandLineTool
baseCommand: happy
label: happy-python_happy
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container build
  process.\n\nTool homepage: https://github.com/AntoineHo/HapPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
stdout: happy-python_happy.out
