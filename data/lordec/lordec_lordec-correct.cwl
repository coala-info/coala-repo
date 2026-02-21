cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-correct
label: lordec_lordec-correct
doc: "LoRDEC (Long Read De-bruijn Graph Error Correction) is a hybrid error correction
  tool for long reads using short reads. Note: The provided help text contains only
  system error messages regarding container execution and does not list available
  command-line arguments.\n\nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--ha87ae23_0
stdout: lordec_lordec-correct.out
