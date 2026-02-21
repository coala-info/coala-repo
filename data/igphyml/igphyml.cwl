cwlVersion: v1.2
class: CommandLineTool
baseCommand: igphyml
label: igphyml
doc: "The provided text does not contain help information for igphyml; it contains
  container runtime error messages regarding disk space.\n\nTool homepage: https://igphyml.readthedocs.io/en/latest/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igphyml:1.1.5--h7b50bb2_2
stdout: igphyml.out
