cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakentools
label: krakentools
doc: "The provided text does not contain help documentation. It contains system error
  messages related to a failed container image build (no space left on device).\n\n
  Tool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
stdout: krakentools.out
