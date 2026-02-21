cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis-msi2
label: mantis-msi2
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/nh13/MANTIS2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis-msi2:2.0.0--h9948957_3
stdout: mantis-msi2.out
