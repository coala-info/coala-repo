cwlVersion: v1.2
class: CommandLineTool
baseCommand: variabel_time_scatter_plot.py
label: variabel_time_scatter_plot.py
doc: "A tool for generating time scatter plots, part of the variabel package. (Note:
  The provided text contains container build logs and error messages rather than the
  tool's help documentation.)\n\nTool homepage: https://gitlab.com/treangenlab/variabel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variabel:1.0.0--hdfd78af_0
stdout: variabel_time_scatter_plot.py.out
