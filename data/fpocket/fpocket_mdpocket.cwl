cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdpocket
label: fpocket_mdpocket
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding disk space during a container
  build process.\n\nTool homepage: https://github.com/Discngine/fpocket"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fpocket:4.0.0
stdout: fpocket_mdpocket.out
