cwlVersion: v1.2
class: CommandLineTool
baseCommand: simplesam
label: simplesam
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  http://mattshirley.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simplesam:0.1.4.1--pyh5e36f6f_0
stdout: simplesam.out
