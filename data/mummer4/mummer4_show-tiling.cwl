cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-tiling
label: mummer4_show-tiling
doc: "The provided text contains a system error message (no space left on device)
  rather than the tool's help documentation. Based on the tool name hint 'mummer4_show-tiling',
  this tool is part of the MUMmer package and is used to calculate a tiling path from
  the matches found by nucmer or promer.\n\nTool homepage: https://mummer4.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_show-tiling.out
