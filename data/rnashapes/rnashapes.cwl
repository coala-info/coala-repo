cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnashapes
label: rnashapes
doc: "RNA secondary structure analysis tool (Note: The provided text contains container
  runtime error logs and does not include usage information or argument descriptions).\n
  \nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/rnashapes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnashapes:3.4.0--pl5321h9948957_3
stdout: rnashapes.out
