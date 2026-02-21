cwlVersion: v1.2
class: CommandLineTool
baseCommand: vapor
label: vapor
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container image build/fetch process.\n\n
  Tool homepage: https://github.com/connor-lab/vapor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vapor:1.0.3--pyhdfd78af_0
stdout: vapor.out
