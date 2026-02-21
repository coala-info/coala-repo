cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphmap
label: graphmap
doc: "GraphMap is a novel mapper for long and error-prone reads.\n\nTool homepage:
  https://github.com/lbcb-sci/graphmap2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphmap:0.6.4--hdcf5f25_0
stdout: graphmap.out
