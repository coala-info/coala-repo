cwlVersion: v1.2
class: CommandLineTool
baseCommand: aniso8601
label: aniso8601
doc: "A library for parsing ISO 8601 strings.\n\nTool homepage: https://github.com/sloanlance/aniso8601"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aniso8601:1.1.0--py35_0
stdout: aniso8601.out
