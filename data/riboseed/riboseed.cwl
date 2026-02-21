cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboseed
label: riboseed
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container image build/fetch process for the riboseed
  tool.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed.out
