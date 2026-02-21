cwlVersion: v1.2
class: CommandLineTool
baseCommand: yaggo
label: yaggo
doc: "\nTool homepage: https://github.com/gmarcais/yaggo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/yaggo:v1.5.10-2-deb_cv1
stdout: yaggo.out
