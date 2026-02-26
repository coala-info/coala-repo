cwlVersion: v1.2
class: CommandLineTool
baseCommand: panacus
label: panacus_plot
doc: "Panacus is a tool for analyzing and visualizing genomic data.\n\nTool homepage:
  https://github.com/marschall-lab/panacus"
inputs:
  - id: command
    type: string
    doc: The command to run (e.g., report, plot)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
stdout: panacus_plot.out
