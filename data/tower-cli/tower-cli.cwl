cwlVersion: v1.2
class: CommandLineTool
baseCommand: tower-cli
label: tower-cli
doc: "The provided text does not contain help information or usage instructions for
  tower-cli; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/seqeralabs/tower-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tower-cli:0.21.0--hdfd78af_0
stdout: tower-cli.out
