cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastani
label: pyfastani
doc: "A Python implementation of the FastANI algorithm for computing average nucleotide
  identity.\n\nTool homepage: https://github.com/althonos/pyfastani"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastani:0.6.1--py39h746d604_0
stdout: pyfastani.out
