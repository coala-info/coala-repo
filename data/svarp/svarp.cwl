cwlVersion: v1.2
class: CommandLineTool
baseCommand: svarp
label: svarp
doc: "Structural variant annotation and prioritization tool. (Note: The provided input
  text contained system logs rather than help documentation; no arguments could be
  extracted.)\n\nTool homepage: https://github.com/asylvz/SVarp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svarp:1.1.1--h077b44d_0
stdout: svarp.out
