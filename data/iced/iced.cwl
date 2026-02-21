cwlVersion: v1.2
class: CommandLineTool
baseCommand: iced
label: iced
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/hiclib/iced"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iced:0.6.0--py312h0fa9677_0
stdout: iced.out
