cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoplot
label: nanoplot
doc: "NanoPlot is a tool for creating various plots and statistics from long-read
  sequencing data (e.g., Oxford Nanopore or PacBio).\n\nTool homepage: https://github.com/wdecoster/NanoPlot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoplot:1.46.2--pyhdfd78af_0
stdout: nanoplot.out
