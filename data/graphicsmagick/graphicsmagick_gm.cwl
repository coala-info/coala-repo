cwlVersion: v1.2
class: CommandLineTool
baseCommand: gm
label: graphicsmagick_gm
doc: "GraphicsMagick provides a set of command-line utilities to manipulate and operate
  on image files.\n\nTool homepage: http://www.graphicsmagick.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
stdout: graphicsmagick_gm.out
