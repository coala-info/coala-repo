cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNALfold
label: viennarna_RNALfold
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error logs indicating a failure to fetch the image.\n\nTool homepage:
  http://www.tbi.univie.ac.at/RNA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: viennarna_RNALfold.out
