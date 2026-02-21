cwlVersion: v1.2
class: CommandLineTool
baseCommand: mappy
label: mappy_minimap2
doc: "Python binding for minimap2 (Note: The provided help text contains system error
  messages and no usage information; no arguments could be extracted).\n\nTool homepage:
  https://github.com/lh3/minimap2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mappy:2.30--py39h0699b22_0
stdout: mappy_minimap2.out
