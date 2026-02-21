cwlVersion: v1.2
class: CommandLineTool
baseCommand: erne
label: erne
doc: "ERNE (Extended Randomized Numerical Environment) is a short read mapping tool.
  (Note: The provided text contains container runtime error messages and does not
  include the tool's help documentation or usage instructions.)\n\nTool homepage:
  https://github.com/chengyuanba/avatar_ernerf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/erne:2.1.1--boost1.61_0
stdout: erne.out
