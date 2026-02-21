cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddqc
label: ddqc
doc: "Data-Driven Quality Control. (Note: The provided text contains system error
  messages regarding container execution and does not include the tool's help documentation
  or argument list.)\n\nTool homepage: https://github.com/ayshwaryas/ddqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddqc:1.0--pyh7e72e81_0
stdout: ddqc.out
