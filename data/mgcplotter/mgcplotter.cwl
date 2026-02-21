cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgcplotter
label: mgcplotter
doc: "A tool for plotting Multiscale Graph Correlation (MGC) results. (Note: The provided
  text contains system error messages and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/moshi4/MGCplotter/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgcplotter:1.0.1--pyhdfd78af_0
stdout: mgcplotter.out
