cwlVersion: v1.2
class: CommandLineTool
baseCommand: pupmapper
label: pupmapper
doc: "A tool for mapping (Note: The provided text is a container build log and does
  not contain help documentation or argument definitions).\n\nTool homepage: https://github.com/maxgmarin/pupmapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pupmapper:0.1.0--pyhdfd78af_0
stdout: pupmapper.out
