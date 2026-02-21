cwlVersion: v1.2
class: CommandLineTool
baseCommand: strdust
label: strdust
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime logs and a fatal error message regarding an
  image build failure.\n\nTool homepage: https://github.com/wdecoster/STRdust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strdust:0.14.0--hcdda2d0_0
stdout: strdust.out
