cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAplot
label: viennarna_RNAplot
doc: "The provided text does not contain help information as it is a container execution
  error log. RNAplot is a tool from the ViennaRNA package used to generate secondary
  structure plots.\n\nTool homepage: http://www.tbi.univie.ac.at/RNA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: viennarna_RNAplot.out
