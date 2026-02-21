cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc-exist
label: fuc_fuc-exist
doc: "\nTool homepage: https://github.com/sbslee/fuc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-exist.out
