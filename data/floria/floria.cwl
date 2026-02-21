cwlVersion: v1.2
class: CommandLineTool
baseCommand: floria
label: floria
doc: "Floria is a tool for strain-level profiling (Note: The provided text contains
  only system error logs and no help information).\n\nTool homepage: https://github.com/bluenote-1577/floria"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/floria:0.0.2--ha6fb395_0
stdout: floria.out
