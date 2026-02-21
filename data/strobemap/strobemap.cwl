cwlVersion: v1.2
class: CommandLineTool
baseCommand: strobemap
label: strobemap
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container image build failure.\n\nTool homepage: https://github.com/ksahlin/strobemers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strobemap:0.0.2--h077b44d_4
stdout: strobemap.out
