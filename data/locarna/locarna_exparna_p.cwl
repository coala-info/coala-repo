cwlVersion: v1.2
class: CommandLineTool
baseCommand: locarna_exparna_p
label: locarna_exparna_p
doc: "LocARNA Exparna-P tool (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://s-will.github.io/LocARNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locarna:2.0.1--pl5321h9948957_2
stdout: locarna_exparna_p.out
