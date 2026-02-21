cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bxtools
  - group
label: bxtools_group
doc: "Tool functionality not yet implemented.\n\nTool homepage: https://github.com/walaj/bxtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
stdout: bxtools_group.out
