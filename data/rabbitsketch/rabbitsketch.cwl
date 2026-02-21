cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabbitsketch
label: rabbitsketch
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container image build/fetch process.\n\nTool homepage:
  https://github.com/RabbitBio/RabbitSketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbitsketch:0.1.1--py39h5ca1c30_0
stdout: rabbitsketch.out
