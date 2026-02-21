cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupiterplot
label: jupiterplot
doc: "JupiterPlot is a tool for visualizing synteny between genomes. (Note: The provided
  help text contains only system error messages and does not list specific arguments.)\n
  \nTool homepage: https://github.com/JustinChu/JupiterPlot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jupiterplot:1.1--hdfd78af_0
stdout: jupiterplot.out
