cwlVersion: v1.2
class: CommandLineTool
baseCommand: babappalign
label: babappalign
doc: "The provided text contains system error messages regarding disk space and container
  image retrieval rather than the tool's help documentation. As a result, no arguments
  or descriptions could be extracted.\n\nTool homepage: https://github.com/sinhakrishnendu/BABAPPAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/babappalign:1.2.0--py313h9ee0642_0
stdout: babappalign.out
