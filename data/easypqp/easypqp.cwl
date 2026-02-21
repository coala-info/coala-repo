cwlVersion: v1.2
class: CommandLineTool
baseCommand: easypqp
label: easypqp
doc: "EasyPQP is a tool for library generation and peak group scoring in mass spectrometry
  proteomics.\n\nTool homepage: https://github.com/grosenberger/easypqp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.55--pyhdfd78af_0
stdout: easypqp.out
