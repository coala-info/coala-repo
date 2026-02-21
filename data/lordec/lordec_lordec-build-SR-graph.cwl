cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-build-SR-graph
label: lordec_lordec-build-SR-graph
doc: "A tool from the LoRDEC suite for building a Short Read (SR) graph. (Note: The
  provided help text contains system error messages and does not list usage or arguments).\n
  \nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--ha87ae23_0
stdout: lordec_lordec-build-SR-graph.out
