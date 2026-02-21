cwlVersion: v1.2
class: CommandLineTool
baseCommand: PopLDDecay
label: poplddecay
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs and a fatal error related to a container image
  build failure.\n\nTool homepage: https://github.com/BGI-shenzhen/PopLDdecay"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poplddecay:3.43--hdcf5f25_1
stdout: poplddecay.out
