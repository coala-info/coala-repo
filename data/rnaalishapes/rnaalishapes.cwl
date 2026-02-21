cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaalishapes
label: rnaalishapes
doc: "RNAalishapes is a tool for predicting the consensus secondary structure shapes
  of an RNA alignment. (Note: The provided text is an error log and does not contain
  usage information or argument definitions.)\n\nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/rnaalishapes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaalishapes:2.5.0--pl5321h9948957_2
stdout: rnaalishapes.out
