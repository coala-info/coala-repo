cwlVersion: v1.2
class: CommandLineTool
baseCommand: squigulator
label: squigulator
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime logs and a fatal error message.\n\nTool homepage:
  https://github.com/hasindu2008/squigulator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squigulator:0.4.0--h5ca1c30_2
stdout: squigulator.out
