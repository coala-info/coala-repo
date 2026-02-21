cwlVersion: v1.2
class: CommandLineTool
baseCommand: chisel
label: chisel
doc: "The provided text does not contain help documentation or usage instructions.
  It is a system log reporting a container build failure due to insufficient disk
  space.\n\nTool homepage: https://github.com/raphael-group/chisel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chisel:1.1.4--pyhdfd78af_0
stdout: chisel.out
