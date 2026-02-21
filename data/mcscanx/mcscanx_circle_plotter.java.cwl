cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcscanx_circle_plotter
label: mcscanx_circle_plotter.java
doc: "A tool for generating circle plots from MCScanX results. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list command-line arguments.\n\nTool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_circle_plotter.java.out
