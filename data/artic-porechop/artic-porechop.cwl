cwlVersion: v1.2
class: CommandLineTool
baseCommand: artic-porechop
label: artic-porechop
doc: "The provided text does not contain help information for artic-porechop. It contains
  container execution logs and a fatal error indicating the executable was not found.\n
  \nTool homepage: https://github.com/artic-network/Porechop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic-porechop:3.2pre1--py36hc9558a2_0
stdout: artic-porechop.out
