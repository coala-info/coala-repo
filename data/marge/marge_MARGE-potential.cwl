cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MARGE-potential
label: marge_MARGE-potential
doc: "MARGE (Model-based Analysis of Regulation of Gene Expression) potential analysis
  tool. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  http://cistrome.org/MARGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marge:1.0--py35h24bf2e0_1
stdout: marge_MARGE-potential.out
