cwlVersion: v1.2
class: CommandLineTool
baseCommand: ifeature
label: ifeature
doc: "A Python toolkit for generating various numerical representation schemes from
  protein or peptide sequences.\n\nTool homepage: https://github.com/Jie-Yuan/iFeature"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ifeature:0.0.6--pyh3252c3a_0
stdout: ifeature.out
