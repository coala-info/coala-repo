cwlVersion: v1.2
class: CommandLineTool
baseCommand: unfazed
label: unfazed
doc: "\nTool homepage: https://github.com/jbelyeu/unfazed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unfazed:1.0.2--pyh3252c3a_0
stdout: unfazed.out
