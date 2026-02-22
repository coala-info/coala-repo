cwlVersion: v1.2
class: CommandLineTool
baseCommand: padel
label: padel
doc: "PaDEL-Descriptor: A software for calculating molecular descriptors and fingerprints.\n\
  \nTool homepage: https://github.com/Joao-M-Silva/padel_analytics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/padel:2.21--2
stdout: padel.out
