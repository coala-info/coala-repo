cwlVersion: v1.2
class: CommandLineTool
baseCommand: qfilt
label: qfilt
doc: "The provided text does not contain help information for the tool 'qfilt'. It
  appears to be a log of a failed container build or fetch operation.\n\nTool homepage:
  https://github.com/NathanGodey/qfilters"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qfilt:0.0.1--h9948957_7
stdout: qfilt.out
