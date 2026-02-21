cwlVersion: v1.2
class: CommandLineTool
baseCommand: tcfinder
label: tcfinder
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container image build/fetch process.\n\nTool homepage:
  https://github.com/PathoGenOmics-Lab/tcfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tcfinder:1.0.0--h4349ce8_0
stdout: tcfinder.out
