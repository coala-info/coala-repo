cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfviewer
label: gfviewer
doc: "A tool for visualizing GFA (Graphical Fragment Assembly) files. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.)\n\nTool homepage: https://github.com/sakshar/GFViewer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfviewer:1.0.4--pyhdfd78af_0
stdout: gfviewer.out
