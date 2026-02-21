cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlocarna
label: locarna_mlocarna
doc: "Multiple alignment of RNAs (Note: The provided help text contains only system
  error messages and no tool-specific usage information).\n\nTool homepage: https://s-will.github.io/LocARNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locarna:2.0.1--pl5321h9948957_2
stdout: locarna_mlocarna.out
