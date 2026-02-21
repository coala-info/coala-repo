cwlVersion: v1.2
class: CommandLineTool
baseCommand: gempipe
label: gempipe
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  creation.\n\nTool homepage: https://github.com/lazzarigioele/gempipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gempipe:1.38.5--pyhdfd78af_0
stdout: gempipe.out
