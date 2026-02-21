cwlVersion: v1.2
class: CommandLineTool
baseCommand: encyclopedia
label: encyclopedia
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image acquisition.\n\nTool homepage: https://bitbucket.org/searleb/encyclopedia/wiki/Home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/encyclopedia:2.12.30--hdfd78af_0
stdout: encyclopedia.out
