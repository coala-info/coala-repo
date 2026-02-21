cwlVersion: v1.2
class: CommandLineTool
baseCommand: vamos
label: vamos
doc: "The provided text does not contain a description of the tool. It appears to
  be an error log from a container build process.\n\nTool homepage: https://github.com/ChaissonLab/vamos"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vamos:3.0.6--h7f5d12c_0
stdout: vamos.out
