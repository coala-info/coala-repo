cwlVersion: v1.2
class: CommandLineTool
baseCommand: ratt
label: ratt
doc: "The provided text does not contain help information or usage instructions for
  the tool 'ratt'. It consists of system logs and a fatal error message related to
  fetching a container image.\n\nTool homepage: http://ratt.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ratt:1.1.0--hdfd78af_0
stdout: ratt.out
