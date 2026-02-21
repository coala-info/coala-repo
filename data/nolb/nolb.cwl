cwlVersion: v1.2
class: CommandLineTool
baseCommand: nolb
label: nolb
doc: "NOLB (Non-Linear Normal Mode Analysis) is a tool for molecular dynamics and
  structural biology, though the provided text contains only system error messages
  and no usage information.\n\nTool homepage: https://team.inria.fr/nano-d/software/nolb-normal-modes/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nolb:1.9--h9ee0642_0
stdout: nolb.out
