cwlVersion: v1.2
class: CommandLineTool
baseCommand: chisel
label: chisel_chisel_main
doc: "CHISEL (Copy-number Haplotype Inference from Single-cell rEad counts). Note:
  The provided help text contains only system error logs and no usage information.\n
  \nTool homepage: https://github.com/raphael-group/chisel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chisel:1.1.4--pyhdfd78af_0
stdout: chisel_chisel_main.out
