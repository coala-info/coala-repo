cwlVersion: v1.2
class: CommandLineTool
baseCommand: pretext-suite
label: pretext-suite
doc: "The provided text does not contain help information or usage instructions for
  pretext-suite; it appears to be a log of a failed container image build/fetch process.\n
  \nTool homepage: https://github.com/wtsi-hpag/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretext-suite:0.0.2--0
stdout: pretext-suite.out
