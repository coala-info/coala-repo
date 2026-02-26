cwlVersion: v1.2
class: CommandLineTool
baseCommand: gm
label: graphicsmagick_gm
doc: "GraphicsMagick 1.3.46 2025-10-29 Q8 http://www.GraphicsMagick.org/\n\nTool homepage:
  http://www.graphicsmagick.org/"
inputs:
  - id: command
    type: string
    doc: The command to get help for
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
stdout: graphicsmagick_gm.out
