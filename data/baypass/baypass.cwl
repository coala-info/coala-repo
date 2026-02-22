cwlVersion: v1.2
class: CommandLineTool
baseCommand: baypass
label: baypass
doc: "BayPass is a population genomics software package which allows identifying genetic
  markers involved in adaptation to environmental conditions and/or subjected to divergent
  selection.\n\nTool homepage: http://www1.montpellier.inra.fr/CBGP/software/baypass/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baypass:3.1--h8d36177_0
stdout: baypass.out
