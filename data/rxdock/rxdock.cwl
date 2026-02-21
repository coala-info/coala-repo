cwlVersion: v1.2
class: CommandLineTool
baseCommand: rxdock
label: rxdock
doc: "The provided text does not contain help information or usage instructions for
  rxdock. It contains log messages related to a failed container image build/fetch
  process.\n\nTool homepage: https://www.rxdock.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rxdock:2013.1.1_148c5bd1--pl5321h8ea774a_3
stdout: rxdock.out
