cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabbitsketch
label: rabbitsketch_exe_minhash
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container image build failure.\n
  \nTool homepage: https://github.com/RabbitBio/RabbitSketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbitsketch:0.1.1--py39h5ca1c30_0
stdout: rabbitsketch_exe_minhash.out
