cwlVersion: v1.2
class: CommandLineTool
baseCommand: sinto
label: sinto
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sinto'. It contains log messages and a fatal error related to a container
  image build process.\n\nTool homepage: https://timoast.github.io/sinto/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
stdout: sinto.out
