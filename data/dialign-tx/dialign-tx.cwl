cwlVersion: v1.2
class: CommandLineTool
baseCommand: dialign-tx
label: dialign-tx
doc: "DIALIGN-TX is a tool for multiple sequence alignment. (Note: The provided input
  text contains system error messages regarding container execution and does not include
  usage instructions or argument definitions.)\n\nTool homepage: https://dialign-tx.gobics.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dialign-tx:v1.0.2-12-deb_cv1
stdout: dialign-tx.out
