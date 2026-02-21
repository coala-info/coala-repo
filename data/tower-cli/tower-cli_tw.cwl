cwlVersion: v1.2
class: CommandLineTool
baseCommand: tw
label: tower-cli_tw
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/seqeralabs/tower-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tower-cli:0.21.0--hdfd78af_0
stdout: tower-cli_tw.out
