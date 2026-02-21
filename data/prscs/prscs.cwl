cwlVersion: v1.2
class: CommandLineTool
baseCommand: prscs
label: prscs
doc: "The provided text does not contain help information or documentation for the
  tool; it contains error logs related to a container image build failure.\n\nTool
  homepage: https://github.com/getian107/PRScs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prscs:1.1.0--hdfd78af_0
stdout: prscs.out
