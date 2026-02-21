cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphicsmagick
label: graphicsmagick
doc: "The provided text does not contain help information or usage instructions for
  GraphicsMagick. It contains system log messages and a fatal error regarding a container
  build failure (no space left on device).\n\nTool homepage: http://www.graphicsmagick.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
stdout: graphicsmagick.out
