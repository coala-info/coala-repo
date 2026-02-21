cwlVersion: v1.2
class: CommandLineTool
baseCommand: manorm
label: manorm
doc: "MAnorm is a tool for quantitative comparison of ChIP-Seq data (Note: The provided
  help text contains only system error messages and no usage information).\n\nTool
  homepage: https://github.com/shao-lab/MAnorm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manorm:1.3.0--py_0
stdout: manorm.out
