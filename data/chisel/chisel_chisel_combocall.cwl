cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chisel
  - combocall
label: chisel_chisel_combocall
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a container image due to
  lack of disk space.\n\nTool homepage: https://github.com/raphael-group/chisel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chisel:1.1.4--pyhdfd78af_0
stdout: chisel_chisel_combocall.out
