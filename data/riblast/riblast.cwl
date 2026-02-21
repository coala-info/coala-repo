cwlVersion: v1.2
class: CommandLineTool
baseCommand: riblast
label: riblast
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a failed container image build/fetch process.\n
  \nTool homepage: https://github.com/fukunagatsu/RIblast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riblast:1.2.0--h077b44d_2
stdout: riblast.out
