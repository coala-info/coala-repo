cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgt-THOR
label: rgt_rgt-THOR
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container image build failure.\n\nTool
  homepage: http://www.regulatory-genomics.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgt:1.0.2--py37he4a0461_0
stdout: rgt_rgt-THOR.out
