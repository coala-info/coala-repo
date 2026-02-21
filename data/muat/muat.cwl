cwlVersion: v1.2
class: CommandLineTool
baseCommand: muat
label: muat
doc: "The provided text does not contain help documentation or usage instructions.
  It consists of system log messages and a fatal error regarding disk space during
  a container build process.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
stdout: muat.out
