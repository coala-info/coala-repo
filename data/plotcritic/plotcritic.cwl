cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotcritic
label: plotcritic
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or extract the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/jbelyeu/PlotCritic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plotcritic:1.0.1--pyh5e36f6f_0
stdout: plotcritic.out
