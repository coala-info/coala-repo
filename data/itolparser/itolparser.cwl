cwlVersion: v1.2
class: CommandLineTool
baseCommand: itolparser
label: itolparser
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding disk space during a container
  image pull.\n\nTool homepage: https://github.com/boasvdp/itolparser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itolparser:0.2.1--pyh7cba7a3_0
stdout: itolparser.out
