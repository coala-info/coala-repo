cwlVersion: v1.2
class: CommandLineTool
baseCommand: scoring-matrices
label: scoring-matrices
doc: "A tool for handling scoring matrices. (Note: The provided input text consists
  of system error messages regarding container execution and does not contain help
  documentation or argument definitions).\n\nTool homepage: https://github.com/althonos/scoring-matrices"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scoring-matrices:0.3.4--py39hbcbf7aa_0
stdout: scoring-matrices.out
