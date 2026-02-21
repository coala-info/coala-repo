cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - goldrush
  - path-tigmint
label: goldrush_path-tigmint
doc: "GoldRush path-tigmint (Note: The provided help text contains only container
  runtime error messages and no usage information.)\n\nTool homepage: https://github.com/bcgsc/goldrush"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
stdout: goldrush_path-tigmint.out
