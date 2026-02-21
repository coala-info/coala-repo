cwlVersion: v1.2
class: CommandLineTool
baseCommand: albatradis
label: albatradis
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/quadram-institute-bioscience/albatradis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/albatradis:1.1.2--py39hbcbf7aa_0
stdout: albatradis.out
