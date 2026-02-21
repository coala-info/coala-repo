cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfa1
label: gfa1
doc: "A tool for handling GFA1 (Graphical Fragment Assembly) files. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/lh3/gfa1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
stdout: gfa1.out
