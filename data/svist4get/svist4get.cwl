cwlVersion: v1.2
class: CommandLineTool
baseCommand: svist4get
label: svist4get
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a failed container image retrieval.\n
  \nTool homepage: https://bitbucket.org/artegorov/svist4get/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svist4get:1.3.1.1--pyhdfd78af_0
stdout: svist4get.out
