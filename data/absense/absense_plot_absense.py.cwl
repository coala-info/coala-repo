cwlVersion: v1.2
class: CommandLineTool
baseCommand: absense_plot_absense.py
label: absense_plot_absense.py
doc: "A tool for plotting ABSENSE results. (Note: The provided text is a system error
  log regarding container extraction and does not contain the actual help documentation
  or argument definitions for the tool.)\n\nTool homepage: https://github.com/caraweisman/abSENSE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
stdout: absense_plot_absense.py.out
