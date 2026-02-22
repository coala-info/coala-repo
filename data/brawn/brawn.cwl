cwlVersion: v1.2
class: CommandLineTool
baseCommand: brawn
label: brawn
doc: "BRAWN (Note: The provided text contains system error messages regarding container
  execution and does not include the tool's help documentation or usage instructions).\n\
  \nTool homepage: https://github.com/SJShaw/brawn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/brawn:1.0.2--pyhdfd78af_0
stdout: brawn.out
