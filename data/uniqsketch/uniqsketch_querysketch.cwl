cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - uniqsketch
  - querysketch
label: uniqsketch_querysketch
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message regarding a failed SIF build from
  a Docker image.\n\nTool homepage: https://github.com/amazon-science/uniqsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniqsketch:1.1.0--h077b44d_0
stdout: uniqsketch_querysketch.out
