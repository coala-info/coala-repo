cwlVersion: v1.2
class: CommandLineTool
baseCommand: uniqsketch
label: uniqsketch
doc: "The provided text does not contain help information or usage instructions for
  the tool 'uniqsketch'. It consists of system logs and a fatal error message regarding
  a container image build failure.\n\nTool homepage: https://github.com/amazon-science/uniqsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniqsketch:1.1.0--h077b44d_0
stdout: uniqsketch.out
