cwlVersion: v1.2
class: CommandLineTool
baseCommand: groot
label: groot
doc: "The provided text does not contain help information or a description of the
  tool; it contains environment logs and a fatal error message regarding a container
  build failure.\n\nTool homepage: https://github.com/will-rowe/groot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
stdout: groot.out
