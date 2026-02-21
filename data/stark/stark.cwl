cwlVersion: v1.2
class: CommandLineTool
baseCommand: stark
label: stark
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container image build/fetch process.\n\n
  Tool homepage: https://github.com/hnikaein/stark"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stark:0.1.1--h9948957_7
stdout: stark.out
