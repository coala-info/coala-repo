cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-py
label: bactopia-py
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to container execution and disk
  space issues.\n\nTool homepage: https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-py:1.7.0--pyhdfd78af_0
stdout: bactopia-py.out
