cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyjess
label: pyjess
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log from a container build process.\n\nTool homepage: https://github.com/althonos/pyjess"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyjess:0.9.1--py310h1fe012e_0
stdout: pyjess.out
