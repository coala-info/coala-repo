cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer
label: khmer
doc: "The provided text contains system error messages regarding a container runtime
  failure (no space left on device) and does not contain help documentation or usage
  instructions for the khmer tool.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer.out
