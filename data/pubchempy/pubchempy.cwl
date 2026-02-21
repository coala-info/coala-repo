cwlVersion: v1.2
class: CommandLineTool
baseCommand: pubchempy
label: pubchempy
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/mcs07/PubChemPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pubchempy:1.0.4--py_0
stdout: pubchempy.out
