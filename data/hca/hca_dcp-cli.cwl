cwlVersion: v1.2
class: CommandLineTool
baseCommand: hca
label: hca_dcp-cli
doc: "Human Cell Atlas (HCA) Data Coordination Platform (DCP) CLI. (Note: The provided
  text contains container runtime error logs and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/HumanCellAtlas/dcp-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hca:7.0.1--py_0
stdout: hca_dcp-cli.out
