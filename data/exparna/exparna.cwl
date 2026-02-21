cwlVersion: v1.2
class: CommandLineTool
baseCommand: exparna
label: exparna
doc: "ExpaRNA (Exact Pattern of RNA) is a tool for fast alignment of RNA molecules.
  Note: The provided text contains system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/BackofenLab/ExpaRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/exparna:1.0.1--pl5321h9f5acd7_5
stdout: exparna.out
