cwlVersion: v1.2
class: CommandLineTool
baseCommand: disulfinder
label: disulfinder
doc: "disulfinder is a tool for predicting the disulfide bonding state of cysteines
  and their connectivity patterns from sequence alone.\n\nTool homepage: https://github.com/ajvenkat/disulfinder-test"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/disulfinder:v1.2.11-8-deb_cv1
stdout: disulfinder.out
