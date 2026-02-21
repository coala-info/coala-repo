cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis-msi
label: mantis-msi
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log regarding a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/OSU-SRLab/MANTIS/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis-msi:1.0.5--h4ac6f70_2
stdout: mantis-msi.out
