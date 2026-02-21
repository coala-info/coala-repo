cwlVersion: v1.2
class: CommandLineTool
baseCommand: hca
label: hca
doc: "Human Cell Atlas Command Line Interface (Note: The provided text is an error
  log and does not contain help information or argument definitions).\n\nTool homepage:
  https://github.com/HumanCellAtlas/dcp-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hca:7.0.1--py_0
stdout: hca.out
