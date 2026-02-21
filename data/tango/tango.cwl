cwlVersion: v1.2
class: CommandLineTool
baseCommand: tango
label: tango
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/fetch process.\n\nTool homepage: https://github.com/johnne/tango"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tango:0.5.7--py_0
stdout: tango.out
