cwlVersion: v1.2
class: CommandLineTool
baseCommand: lightning
label: lightning
doc: "A tool for large-scale linear classification, regression and ranking.\n\nTool
  homepage: https://github.com/Lightning-AI/pytorch-lightning"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightning:0.2.dev0--py36_0
stdout: lightning.out
