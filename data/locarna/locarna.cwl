cwlVersion: v1.2
class: CommandLineTool
baseCommand: locarna
label: locarna
doc: "LocARNA is a tool for multiple alignment of RNA molecules. (Note: The provided
  help text contains only system error messages and no usage information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://s-will.github.io/LocARNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locarna:2.0.1--pl5321h9948957_2
stdout: locarna.out
