cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread_sublong
label: subread_sublong
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages and a fatal error regarding an
  OCI image build failure.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
stdout: subread_sublong.out
