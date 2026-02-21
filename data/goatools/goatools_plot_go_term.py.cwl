cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_go_term.py
label: goatools_plot_go_term.py
doc: "A tool from the goatools suite for plotting GO terms. (Note: The provided text
  contains system error messages regarding container execution and does not include
  the actual help documentation or argument list.)\n\nTool homepage: https://github.com/tanghaibao/goatools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goatools:1.2.3--pyh7cba7a3_2
stdout: goatools_plot_go_term.py.out
