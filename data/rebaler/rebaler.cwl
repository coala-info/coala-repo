cwlVersion: v1.2
class: CommandLineTool
baseCommand: rebaler
label: rebaler
doc: "\nTool homepage: https://github.com/rrwick/Rebaler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rebaler:0.2.0--py_0
stdout: rebaler.out
