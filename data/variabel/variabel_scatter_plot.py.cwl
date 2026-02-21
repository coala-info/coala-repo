cwlVersion: v1.2
class: CommandLineTool
baseCommand: variabel_scatter_plot.py
label: variabel_scatter_plot.py
doc: "A tool for generating scatter plots, likely associated with the variabel (Variant
  Analysis by REad-By-read AnaLysis) suite.\n\nTool homepage: https://gitlab.com/treangenlab/variabel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variabel:1.0.0--hdfd78af_0
stdout: variabel_scatter_plot.py.out
