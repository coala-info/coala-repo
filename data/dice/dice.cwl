cwlVersion: v1.2
class: CommandLineTool
baseCommand: dice
label: dice
doc: "Differential Inference of Chromatin Elements\n\nTool homepage: https://github.com/samsonweiner/DICE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dice:1.1.0--pyhdfd78af_0
stdout: dice.out
