cwlVersion: v1.2
class: CommandLineTool
baseCommand: hulk
label: hulk
doc: "A tool for sketching genomic data (Note: The provided text contains system error
  messages and does not include the actual help documentation for the tool).\n\nTool
  homepage: https://github.com/will-rowe/hulk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hulk:1.0.0--h375a9b1_0
stdout: hulk.out
