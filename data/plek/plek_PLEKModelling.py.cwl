cwlVersion: v1.2
class: CommandLineTool
baseCommand: plek_PLEKModelling.py
label: plek_PLEKModelling.py
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a system error log indicating a failure to build a container image
  due to insufficient disk space.\n\nTool homepage: https://sourceforge.net/projects/plek"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plek:1.2--py310h8ea774a_10
stdout: plek_PLEKModelling.py.out
