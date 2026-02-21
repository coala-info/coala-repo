cwlVersion: v1.2
class: CommandLineTool
baseCommand: paplot_conf
label: paplot_conf
doc: "A tool to display the configuration file path and the default settings for paplot,
  a visualization tool for genomic data.\n\nTool homepage: https://github.com/Genomon-Project/paplot.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paplot:0.5.6--pyh5e36f6f_0
stdout: paplot_conf.out
