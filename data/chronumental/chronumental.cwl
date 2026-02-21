cwlVersion: v1.2
class: CommandLineTool
baseCommand: chronumental
label: chronumental
doc: "Chronumental is a tool for time-tree estimation. (Note: The provided help text
  contains only system error logs regarding a container build failure and does not
  list specific command-line arguments.)\n\nTool homepage: https://github.com/theosanderson/chronumental"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chronumental:0.0.65--pyhdfd78af_0
stdout: chronumental.out
