cwlVersion: v1.2
class: CommandLineTool
baseCommand: itolapi
label: itolapi
doc: "The provided text does not contain help documentation or usage instructions
  for the tool. It consists of system log messages and a fatal error regarding disk
  space during a container image build.\n\nTool homepage: https://github.com/albertyw/itolapi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itolapi:4.1.6--pyhdfd78af_0
stdout: itolapi.out
