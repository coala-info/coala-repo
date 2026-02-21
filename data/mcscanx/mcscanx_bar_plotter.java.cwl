cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcscanx_bar_plotter.java
label: mcscanx_bar_plotter.java
doc: "A tool for plotting bar charts in MCScanX. (Note: The provided text is a system
  error log and does not contain help documentation or argument definitions.)\n\n
  Tool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_bar_plotter.java.out
