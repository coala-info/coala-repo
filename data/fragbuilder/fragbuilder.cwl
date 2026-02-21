cwlVersion: v1.2
class: CommandLineTool
baseCommand: fragbuilder
label: fragbuilder
doc: "The provided text contains system error messages related to a container runtime
  failure and does not include the tool's help documentation. Fragbuilder is generally
  known as a Python library and command-line tool for creating and analyzing peptide
  fragment libraries.\n\nTool homepage: https://github.com/jensengroup/fragbuilder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fragbuilder:1.0.1--hdfd78af_1
stdout: fragbuilder.out
