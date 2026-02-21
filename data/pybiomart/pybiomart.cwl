cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybiomart
label: pybiomart
doc: "A Python interface to BioMart databases.\n\nTool homepage: https://github.com/jrderuiter/pybiomart"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybiomart:0.2.0--pyh864c0ab_1
stdout: pybiomart.out
