cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - obipairing
label: obitools4_obipairing
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding container image creation and disk space issues.\n
  \nTool homepage: https://obitools4.metabarcoding.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obipairing.out
