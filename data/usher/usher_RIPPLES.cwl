cwlVersion: v1.2
class: CommandLineTool
baseCommand: usher_RIPPLES
label: usher_RIPPLES
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs and a fatal error message related to a container
  image build failure.\n\nTool homepage: https://github.com/yatisht/usher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usher:0.6.6--h719ac0c_1
stdout: usher_RIPPLES.out
