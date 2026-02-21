cwlVersion: v1.2
class: CommandLineTool
baseCommand: samplot
label: samplot
doc: "The provided text does not contain help documentation or usage instructions;
  it is a log of a failed container build/fetch process for the samplot tool.\n\n
  Tool homepage: https://github.com/ryanlayer/samplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samplot:1.3.0--pyh5e36f6f_1
stdout: samplot.out
