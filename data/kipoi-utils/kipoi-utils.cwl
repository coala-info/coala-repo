cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi-utils
label: kipoi-utils
doc: "Utilities for Kipoi (Note: The provided text contains system error messages
  and does not include help documentation or argument definitions).\n\nTool homepage:
  https://github.com/kipoi/kipoi-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi-utils:0.7.7--pyh7cba7a3_0
stdout: kipoi-utils.out
