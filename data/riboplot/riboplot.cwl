cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboplot
label: riboplot
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a container execution failure.\n\nTool homepage: https://github.com/hsinyenwu/RiboPlotR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboplot:0.3.1--py27_0
stdout: riboplot.out
