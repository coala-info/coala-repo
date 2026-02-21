cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfaview
label: gfa1_gfaview
doc: "A tool for viewing and processing GFA1 (Graphical Fragment Assembly) files.\n
  \nTool homepage: https://github.com/lh3/gfa1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
stdout: gfa1_gfaview.out
