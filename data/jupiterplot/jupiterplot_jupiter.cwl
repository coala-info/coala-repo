cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jupiterplot
  - jupiter
label: jupiterplot_jupiter
doc: "JupiterPlot is a tool for visualizing synteny between two genomes. (Note: The
  provided help text contained only system error messages and no usage information;
  arguments could not be extracted.)\n\nTool homepage: https://github.com/JustinChu/JupiterPlot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jupiterplot:1.1--hdfd78af_0
stdout: jupiterplot_jupiter.out
