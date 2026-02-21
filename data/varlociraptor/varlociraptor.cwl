cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlociraptor
label: varlociraptor
doc: "The provided text is a container runtime error log and does not contain help
  documentation or argument definitions for the tool.\n\nTool homepage: https://varlociraptor.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
stdout: varlociraptor.out
