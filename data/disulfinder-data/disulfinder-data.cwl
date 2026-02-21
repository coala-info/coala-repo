cwlVersion: v1.2
class: CommandLineTool
baseCommand: disulfinder-data
label: disulfinder-data
doc: Data package for disulfinder, a tool for predicting the disulfide bonding state
  of cysteines and their connectivity patterns.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/disulfinder-data:v1.2.11-8-deb_cv1
stdout: disulfinder-data.out
