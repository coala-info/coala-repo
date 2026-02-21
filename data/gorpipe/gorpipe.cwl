cwlVersion: v1.2
class: CommandLineTool
baseCommand: gorpipe
label: gorpipe
doc: "The provided text does not contain help documentation for gorpipe; it contains
  system logs and a fatal error message regarding container image creation and disk
  space limitations.\n\nTool homepage: https://github.com/gorpipe/gor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gorpipe:4.5.0--hdfd78af_0
stdout: gorpipe.out
