cwlVersion: v1.2
class: CommandLineTool
baseCommand: colorbrewer
label: colorbrewer
doc: "A tool for color schemes, likely based on the ColorBrewer palettes.\n\nTool
  homepage: https://github.com/hoffmangroup/colorbrewer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colorbrewer:0.3--pyhdfd78af_0
stdout: colorbrewer.out
