cwlVersion: v1.2
class: CommandLineTool
baseCommand: maelstrom-core
label: maelstrom-core
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/bihealth/maelstrom-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maelstrom-core:0.1.1--he3973ca_3
stdout: maelstrom-core.out
