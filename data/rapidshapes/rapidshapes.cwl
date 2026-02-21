cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapidshapes
label: rapidshapes
doc: "RapidShapes is a tool for high-throughput shape-based virtual screening.\n\n
  Tool homepage: https://bibiserv.cebitec.uni-bielefeld.de/rapidshapes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapidshapes:2.1.0--pl5321h9948957_2
stdout: rapidshapes.out
