cwlVersion: v1.2
class: CommandLineTool
baseCommand: goldrush-path
label: goldrush_goldrush-path
doc: "GoldRush-Path is a tool within the GoldRush suite, likely used for path-related
  genomic assembly or analysis tasks. (Note: The provided help text contains only
  system error logs and no usage information.)\n\nTool homepage: https://github.com/bcgsc/goldrush"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
stdout: goldrush_goldrush-path.out
