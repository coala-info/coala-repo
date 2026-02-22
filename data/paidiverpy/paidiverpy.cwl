cwlVersion: v1.2
class: CommandLineTool
baseCommand: paidiverpy
label: paidiverpy
doc: "A tool for analyzing pathogen diversity (Note: The provided help text contains
  only system error messages regarding disk space and container conversion, so specific
  arguments could not be extracted).\n\nTool homepage: https://github.com/paidiver/paidiverpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paidiverpy:0.2.1--pyhdfd78af_0
stdout: paidiverpy.out
