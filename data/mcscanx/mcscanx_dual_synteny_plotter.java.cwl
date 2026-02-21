cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcscanx_dual_synteny_plotter.java
label: mcscanx_dual_synteny_plotter.java
doc: "A tool for plotting dual synteny maps. (Note: The provided help text contains
  system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_dual_synteny_plotter.java.out
