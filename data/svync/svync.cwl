cwlVersion: v1.2
class: CommandLineTool
baseCommand: svync
label: svync
doc: "\nTool homepage: https://github.com/nvnieuwk/svync"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svync:0.3.0--h9ee0642_0
stdout: svync.out
