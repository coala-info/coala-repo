cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfamsa
label: pyfamsa
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a failed container image retrieval.\n\n
  Tool homepage: https://github.com/althonos/pyfamsa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfamsa:0.5.3.post1--py312h9c9b0c2_0
stdout: pyfamsa.out
