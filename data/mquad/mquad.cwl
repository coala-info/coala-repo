cwlVersion: v1.2
class: CommandLineTool
baseCommand: mquad
label: mquad
doc: "MQuad (Note: The provided text is a system error message regarding container
  image acquisition and does not contain tool-specific help documentation or argument
  definitions).\n\nTool homepage: https://github.com/aaronkwc/MQuad"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mquad:0.1.8b--pyhdfd78af_0
stdout: mquad.out
