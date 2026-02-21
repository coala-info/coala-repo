cwlVersion: v1.2
class: CommandLineTool
baseCommand: dominate
label: dominate
doc: "The provided text does not contain help information or usage instructions for
  the tool 'dominate'. It contains system log messages and a fatal error regarding
  container image creation.\n\nTool homepage: https://github.com/Knio/dominate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dominate:2.1.16--py36_0
stdout: dominate.out
