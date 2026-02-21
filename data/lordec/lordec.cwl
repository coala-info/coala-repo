cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec
label: lordec
doc: "LoRDEC (Long Read DNA Error Correction) is a tool for error correction of long
  reads using short reads. Note: The provided help text contains only system error
  messages regarding a container build failure and does not list specific command-line
  arguments.\n\nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--ha87ae23_0
stdout: lordec.out
