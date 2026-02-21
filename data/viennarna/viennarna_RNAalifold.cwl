cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAalifold
label: viennarna_RNAalifold
doc: "The provided text is a container execution error log and does not contain help
  information or argument definitions for RNAalifold.\n\nTool homepage: http://www.tbi.univie.ac.at/RNA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: viennarna_RNAalifold.out
