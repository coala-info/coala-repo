cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimick
label: mimick
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure.\n\nTool homepage:
  https://github.com/pdimens/mimick"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimick:3.0.1--pyh7e72e81_0
stdout: mimick.out
