cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorax
label: lorax
doc: "The provided text does not contain help information or a description for the
  tool; it contains container runtime log messages and a fatal error regarding disk
  space.\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
stdout: lorax.out
