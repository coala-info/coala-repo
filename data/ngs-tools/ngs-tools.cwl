cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs-tools
label: ngs-tools
doc: "A collection of tools for Next-Generation Sequencing (NGS) data analysis. Note:
  The provided text contains error logs and does not list specific CLI arguments or
  usage instructions.\n\nTool homepage: https://github.com/Lioscro/ngs-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-tools:1.8.6--pyhdfd78af_0
stdout: ngs-tools.out
