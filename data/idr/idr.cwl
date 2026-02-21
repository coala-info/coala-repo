cwlVersion: v1.2
class: CommandLineTool
baseCommand: idr
label: idr
doc: "The IDR (Irreproducible Discovery Rate) framework is a unified approach to measure
  the reproducibility of findings identified from replicate experiments and provide
  confidence scores.\n\nTool homepage: https://github.com/kundajelab/idr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idr:2.0.4.2--py39h031d066_12
stdout: idr.out
