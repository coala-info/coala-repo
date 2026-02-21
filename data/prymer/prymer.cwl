cwlVersion: v1.2
class: CommandLineTool
baseCommand: prymer
label: prymer
doc: "The provided text does not contain help information or usage instructions for
  the tool 'prymer'. It is a log of a failed container image build/fetch process.\n
  \nTool homepage: https://pypi.org/project/prymer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prymer:3.0.2--pyhdfd78af_1
stdout: prymer.out
