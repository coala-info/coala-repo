cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabbitqcplus
label: rabbitqcplus
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container image retrieval. RabbitQC+ is generally
  known as a tool for fast quality control of sequencing data.\n\nTool homepage: https://github.com/RabbitBio/RabbitQCPlus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbitqcplus:2.3.0--h5ca1c30_1
stdout: rabbitqcplus.out
