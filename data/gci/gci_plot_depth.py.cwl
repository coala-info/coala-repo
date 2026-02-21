cwlVersion: v1.2
class: CommandLineTool
baseCommand: gci_plot_depth.py
label: gci_plot_depth.py
doc: "A tool for plotting depth (description unavailable due to missing help text
  in provided input).\n\nTool homepage: https://github.com/yeeus/GCI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gci:1.0--hdfd78af_0
stdout: gci_plot_depth.py.out
