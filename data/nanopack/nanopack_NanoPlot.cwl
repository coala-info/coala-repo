cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoPlot
label: nanopack_NanoPlot
doc: "NanoPlot is a tool for creating various plots from long-read sequencing data
  (Oxford Nanopore, PacBio). Note: The provided input text contained only system error
  messages and no help documentation to parse.\n\nTool homepage: https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack_NanoPlot.out
