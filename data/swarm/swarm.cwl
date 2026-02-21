cwlVersion: v1.2
class: CommandLineTool
baseCommand: swarm
label: swarm
doc: "A robust and fast clustering algorithm for amplicon processing.\n\nTool homepage:
  https://github.com/torognes/swarm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swarm:3.1.6--h9948957_0
stdout: swarm.out
