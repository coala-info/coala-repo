cwlVersion: v1.2
class: CommandLineTool
baseCommand: goatools_go_plot.py
label: goatools_go_plot.py
doc: "A tool from the goatools suite for plotting GO terms. Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific arguments.\n\nTool homepage: https://github.com/tanghaibao/goatools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goatools:1.2.3--pyh7cba7a3_2
stdout: goatools_go_plot.py.out
