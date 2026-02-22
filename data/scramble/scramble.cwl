cwlVersion: v1.2
class: CommandLineTool
baseCommand: scramble
label: scramble
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure.\n\nTool homepage:
  https://github.com/GeneDx/scramble"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scramble:1.0.2--h031d066_1
stdout: scramble.out
