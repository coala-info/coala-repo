cwlVersion: v1.2
class: CommandLineTool
baseCommand: poa_cli.py
label: poa_cli.py
doc: "The provided text does not contain help information or usage instructions for
  poa_cli.py. It contains system logs and a fatal error related to a container image
  build process.\n\nTool homepage: https://github.com/jakecreps/poastal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poa:2.0--h779adbc_3
stdout: poa_cli.py.out
