cwlVersion: v1.2
class: CommandLineTool
baseCommand: ciriquant
label: ciriquant
doc: "CIRIquant: A comprehensive pipeline for circular RNA quantification and differential
  expression analysis.\n\nTool homepage: https://github.com/bioinfo-biols/CIRIquant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ciriquant:1.1.3--pyhdfd78af_0
stdout: ciriquant.out
