cwlVersion: v1.2
class: CommandLineTool
baseCommand: yamllint
label: yamllint
doc: "A linter for YAML files.\n\nTool homepage: https://github.com/adrienverge/yamllint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yamllint:1.2.1--py35_0
stdout: yamllint.out
