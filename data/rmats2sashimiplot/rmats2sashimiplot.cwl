cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmats2sashimiplot
label: rmats2sashimiplot
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container build failure.\n\nTool homepage: https://github.com/Xinglab/rmats2sashimiplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmats2sashimiplot:3.0.0--py39hdff8610_2
stdout: rmats2sashimiplot.out
